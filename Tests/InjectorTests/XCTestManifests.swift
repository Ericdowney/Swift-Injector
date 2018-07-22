import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(InjectorTests.allTests),
        testCase(ArrayExtensionsTests.allTests),
    ]
}
#endif
