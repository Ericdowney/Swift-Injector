import XCTest

import InjectorTests

var tests = [XCTestCaseEntry]()
tests += InjectorTests.allTests()
XCTMain(tests)