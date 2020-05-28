
import Foundation

@propertyWrapper
public struct ResolveOptional<Value: Resolvable> {
    
    // MARK: - Properties
    
    public var wrappedValue: Value? {
        if let name = resolvableName {
            return .resolve(for: name)
        }
        return .resolve()
    }
    
    var resolvableName: String?
    
    // MARK: - Lifecycle
    
    public init(name resolvableName: String? = nil, type: Value.Type) {
        self.resolvableName = resolvableName
    }
    
    // MARK: - Methods
}

@propertyWrapper
public struct Resolve<Value: Resolvable> {
    
    // MARK: - Properties
    
    public var wrappedValue: Value {
        var object: Value?
        if let name = resolvableName {
            object = .resolve(for: name)
        }
        object = .resolve()
        guard let unwrappedObject = object else {
            let message = "\(Value.self) is not registered as a Resolvable object."
            NSException(name: .genericException, reason: message, userInfo: nil).raise()
            preconditionFailure(message)
        }
        return unwrappedObject
    }
    
    var resolvableName: String?
    
    // MARK: - Lifecycle
    
    public init(name resolvableName: String? = nil, type resolvableType: Value.Type) {
        self.resolvableName = resolvableName
    }
    
    // MARK: - Methods
}
