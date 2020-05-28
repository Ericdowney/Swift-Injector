
import Foundation

/// Singleton that is capable of automatically resolving dependencies through the use of the Resolvable protocol.
public final class Injector {
    public enum Errors: Error {
        case unresolvable
    }
    
    struct WeakBag {
        var name: String?
        weak var value: Resolvable?
    }
    
    // MARK: - Properties
    
    public static var shared: Injector = .init()
    
    var resolvables: [WeakBag] = []
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Methods
    
    /// Adds a Resolvable object to the Injector singleton's list of resolvable objects.
    ///
    /// - Parameter object: The object that will be resolvable
    public func register(_ objects: Resolvable...) {
        removeReleasedObjects()
        resolvables += objects.map { .init(name: nil, value: $0) }
    }
    
    /// Adds a Resolvable object to the Injector singleton's list of resolvable objects by name.
    /// - Parameters:
    ///   - object: The object that will be resolvable
    ///   - name: The name that identifies the resolvable object
    public func register(_ object: Resolvable, with name: String) {
        removeReleasedObjects()
        resolvables += [.init(name: name, value: object)]
    }
    
    /// Removes a Resolvable object from the Injector singleton's list of resolvable objects. The supplied object must be the exact instance originally registered with the Injector singleton.
    ///
    /// - Parameter obj: The object that will be no longer resolvable
    public func unregister(_ obj: Resolvable) {
        if let index = resolvables.firstIndex(where: { $0.value === obj }) {
            resolvables.remove(at: index)
        }
        removeReleasedObjects()
    }
    
    /// Removes a Resolvable object from the Injector singleton's list of resolvable objects by name.
    /// - Parameter name: The name of the object that will be no longer resolvable
    public func unregister(objectWith name: String) {
        if let index = resolvables.firstIndex(where: { $0.name == name }) {
            resolvables.remove(at: index)
        }
        removeReleasedObjects()
    }
    
    /// Removes all Resolvable objects from the Injector singleton's list of resolvable objects.
    public func unregisterAll() {
        resolvables.removeAll()
    }
    
    func resolve<T>() throws -> T where T: Resolvable {
        guard let object = resolvables.compactMap({ $0.value as? T }).first else { throw Errors.unresolvable }
        return object
    }
    
    func resolve<T>(with name: String) throws -> T where T: Resolvable {
        guard let object = resolvables.filter({ $0.name == name }).first?.value as? T else { throw Errors.unresolvable }
        return object
    }
    
    private func removeReleasedObjects() {
        resolvables = resolvables.filter { $0.value != nil }
    }
}
