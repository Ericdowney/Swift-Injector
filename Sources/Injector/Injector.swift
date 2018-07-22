/// Singleton that is capable of automatically resolving dependencies through the use of the Resolvable protocol.
public struct Injector {
    public enum Errors: Error {
        case unresolvable
    }
    
    struct WeakBag {
        weak var value: Resolvable?
    }
    
    // MARK: - Singleton
    
    public static var shared: Injector = .init()
    
    // MARK: - Properties
    
    var resolvables: [WeakBag] = []
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Methods
    
    /// Adds a Resolvable object to the Injector singleton's list of resolvable objects.
    ///
    /// - Parameter object: The object that will be resolvable
    public mutating func register(_ objects: Resolvable...) {
        resolvables += objects.map { WeakBag(value: $0) }
    }
    
    /// Removes a Resolvable object from the Injector singleton's list of resolvable objects. The supplied object must be the exact instance originally registered with the Injector singleton.
    ///
    /// - Parameter obj: The object that will be no longer resolvable
    public mutating func unregister(_ obj: Resolvable) {
        if let index = resolvables.index(where: { $0.value === obj }) {
            resolvables.remove(at: index)
        }
    }
    
    /// Removes all Resolvable objects from the Injector singleton's list of resolvable objects.
    public mutating func unregisterAll() {
        resolvables.removeAll()
    }
    
    func resolve<T>() throws -> T where T: Resolvable {
        guard let obj: T = resolvables.compactMap({
            $0.value as? T
        }).first else {
            throw Errors.unresolvable
        }
        return obj
    }
}
