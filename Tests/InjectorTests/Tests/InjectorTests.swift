import XCTest
@testable import Injector

final class InjectorTests: XCTestCase {
    
    // MARK: - Tests
    
    override func setUp() {
        super.setUp()
        
        Injector.shared.resolvables.removeAll()
    }
    
    func test_shouldAddResolvableObjectToInjectorResolvablesList() {
        let obj = TestResolvable()
        
        Injector.shared.register(obj)
        
        XCTAssertIdentity(Injector.shared.resolvables.first?.value as! TestResolvable, obj)
    }
    
    func test_shouldAddAllResolvableObjectsToInjectorResolvablesList() {
        let obj1 = TestResolvable()
        let obj2 = TestResolvable()
        let obj3 = TestResolvable()
        
        Injector.shared.register(obj1, obj2, obj3)
        
        XCTAssertIdentity(Injector.shared.resolvables[0].value as! TestResolvable, obj1)
        XCTAssertIdentity(Injector.shared.resolvables[1].value as! TestResolvable, obj2)
        XCTAssertIdentity(Injector.shared.resolvables[2].value as! TestResolvable, obj3)
    }
    
    func test_shouldAddResolvableObjectToInjectorResolvablesListByName() throws {
        let obj1 = TestResolvable()
        let obj2 = TestResolvable()
        
        Injector.shared.register(obj1, with: "Object-1")
        Injector.shared.register(obj2, with: "Object-2")
        
        XCTAssertIdentity(try Injector.shared.resolve(with: "Object-1"), obj1)
        XCTAssertIdentity(try Injector.shared.resolve(with: "Object-2"), obj2)
    }
    
    func test_shouldRemoveResolvableObjectFromInjectorResolvableList() {
        let obj = TestResolvable()
        Injector.shared.register(obj)
        
        Injector.shared.unregister(obj)
        
        XCTAssertEmpty(Injector.shared.resolvables)
    }
    
    func test_shouldRemoveResolvableObjectFromInjectorResolvableListByName() throws {
        let obj1 = TestResolvable()
        let obj2 = TestResolvable()
        Injector.shared.register(obj1, with: "Object-1")
        Injector.shared.register(obj2, with: "Object-2")
        
        Injector.shared.unregister(objectWith: "Object-1")
        
        let actualObj1: TestResolvable? = try? Injector.shared.resolve(with: "Object-1")
        XCTAssertEqual(Injector.shared.resolvables.count, 1)
        XCTAssertNil(actualObj1)
        XCTAssertIdentity(try Injector.shared.resolve(with: "Object-2"), obj2)
    }
    
    func test_shouldRemoveAllResolvableObjectsFromInjectorResolvableList() {
        let obj1 = TestResolvable()
        let obj2 = TestResolvable()
        let obj3 = TestResolvable()
        Injector.shared.register(obj1, obj2, obj3)
        
        Injector.shared.unregisterAll()
        
        XCTAssertEmpty(Injector.shared.resolvables)
    }
    
    func test_shouldResolveOptionalObjectFromInjectorWhenObjectIsRegistered() {
        let obj = TestResolvable()
        Injector.shared.register(obj)
        
        let result: TestResolvable? = .resolve()
        
        XCTAssertIdentity(obj, result)
    }
    
    func test_shouldNotResolveOptionalObjectFromInjectorWhenObjectIsNotRegister() {
        let obj = TestResolvable()
        Injector.shared.register(obj)
        
        let result: TestOtherResolvable? = .resolve()
        
        XCTAssertNil(result)
    }
    
    func test_shouldResolveNonOptionalObjectFromInjectorWhenObjectIsRegistered() throws {
        let obj = TestResolvable()
        Injector.shared.register(obj)
        
        let result: TestResolvable = try .resolve()
        
        XCTAssertIdentity(obj, result)
    }
    
    func test_shouldThrowAnUnresolvableErrorWhenResolvingObjectThatIsNotRegistered() {
        let obj = TestResolvable()
        Injector.shared.register(obj)
        
        XCTAssertThrowsError(try .resolve() as TestOtherResolvable)
    }
    
    func test_shouldHoldObjectsAsAWeakReference() {
        var obj: TestResolvable? = TestResolvable()
        Injector.shared.register(obj!)
        obj = nil
        
        let result: TestResolvable? = .resolve()
        
        XCTAssertNil(result)
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldAddResolvableObjectToInjectorResolvablesList", test_shouldAddResolvableObjectToInjectorResolvablesList),
        ("test_shouldAddAllResolvableObjectsToInjectorResolvablesList", test_shouldAddAllResolvableObjectsToInjectorResolvablesList),
        ("test_shouldRemoveResolvableObjectFromInjectorResolvableList", test_shouldRemoveResolvableObjectFromInjectorResolvableList),
        ("test_shouldRemoveAllResolvableObjectsFromInjectorResolvableList", test_shouldRemoveAllResolvableObjectsFromInjectorResolvableList),
        ("test_shouldResolveOptionalObjectFromInjectorWhenObjectIsRegistered", test_shouldResolveOptionalObjectFromInjectorWhenObjectIsRegistered),
        ("test_shouldNotResolveOptionalObjectFromInjectorWhenObjectIsNotRegister", test_shouldNotResolveOptionalObjectFromInjectorWhenObjectIsNotRegister),
        ("test_shouldResolveNonOptionalObjectFromInjectorWhenObjectIsRegistered", test_shouldResolveNonOptionalObjectFromInjectorWhenObjectIsRegistered),
        ("test_shouldThrowAnUnresolvableErrorWhenResolvingObjectThatIsNotRegistered", test_shouldThrowAnUnresolvableErrorWhenResolvingObjectThatIsNotRegistered),
    ]
}
