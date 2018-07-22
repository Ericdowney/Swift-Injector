import XCTest
@testable import Injector

final class ArrayExtensionsTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_shouldNotRemoveNonMatchingElements() {
        let subject = ["Hello", "There", "Whats", "Up"]
        
        let result = subject.remove(where: { item in
            return item == "Some-Text"
        })
        
        XCTAssertEqual(result, ["Hello", "There", "Whats", "Up"])
    }
    
    func test_shouldRemoveOneMatchingElement() {
        let subject = ["Hello", "There", "Whats", "Up"]

        let result = subject.remove(where: { $0 == "Hello" })

        XCTAssertEqual(result, ["There", "Whats", "Up"])
    }

    func test_shouldRemoveAllMatchingElements() {
        let subject = ["Hello", "Hello", "Hello"]

        let result = subject.remove(where: { $0 == "Hello" })

        XCTAssertEmpty(result)
    }
    
    // MARK: - Test Registration
    
    static var allTests = [
        ("test_shouldNotRemoveNonMatchingElements", test_shouldNotRemoveNonMatchingElements),
        ("test_shouldRemoveOneMatchingElement", test_shouldRemoveOneMatchingElement),
        ("test_shouldRemoveAllMatchingElements", test_shouldRemoveAllMatchingElements),
    ]
}
