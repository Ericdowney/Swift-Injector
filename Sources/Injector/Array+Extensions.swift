
import Foundation

public extension Array {
    /// This method will remove all elements that match the given predicate. **Mutating**
    ///
    /// - Parameter predicate: The predicate to use when deciding which elements to remove from the array.
    func remove(where predicate: (Element) -> Bool) -> [Element] {
        return filter { !predicate($0) }
    }
}
