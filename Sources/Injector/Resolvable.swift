
import Foundation

/// Represents a class object that can be resolved through the Injector singleton. Any object conforming to Resolvable can be instantiated as Non-Optional or Optional through the use of .resolve().
public protocol Resolvable: class {
    static func resolve<T: Resolvable>() throws -> T
    static func resolve<T: Resolvable>() -> T?
    static func resolve<T: Resolvable>(for name: String) throws -> T
    static func resolve<T: Resolvable>(for name: String) -> T?
}

public extension Resolvable {
    
    static func resolve<T: Resolvable>() throws -> T {
        return try Injector.shared.resolve()
    }
    
    static func resolve<T: Resolvable>() -> T? {
        return try? Injector.shared.resolve()
    }
    
    static func resolve<T: Resolvable>(for name: String) throws -> T {
        return try Injector.shared.resolve(with: name)
    }
    
    static func resolve<T: Resolvable>(for name: String) -> T? {
        return try? Injector.shared.resolve(with: name)
    }
}
