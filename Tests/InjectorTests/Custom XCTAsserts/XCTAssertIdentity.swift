//
//  XCTAssertIdentity.swift
//  InjectorTests
//
//  Created by Eric Downey on 7/15/18.
//

import XCTest

func XCTAssertIdentity<Element: AnyObject>(_ expression1: Element, _ expression2: Element, _ message: String? = nil, _ file: StaticString = #file, _ line: UInt = #line) {
    let failureMessage = message ?? "The expressions \(expression1) and \(expression2) identities do not match"
    XCTAssertTrue(expression1 === expression2, failureMessage, file: file, line: line)
}

func XCTAssertIdentity<Element: AnyObject>(_ expression1: Element?, _ expression2: Element, _ message: String? = nil, _ file: StaticString = #file, _ line: UInt = #line) {
    let failureMessage = message ?? "The expressions \(expression1.stringValueOrEmpty) and \(expression2) identities do not match"
    XCTAssertTrue(expression1 === expression2, failureMessage, file: file, line: line)
}

func XCTAssertIdentity<Element: AnyObject>(_ expression1: Element, _ expression2: Element?, _ message: String? = nil, _ file: StaticString = #file, _ line: UInt = #line) {
    let failureMessage = message ?? "The expressions \(expression1) and \(expression2.stringValueOrEmpty) identities do not match"
    XCTAssertTrue(expression1 === expression2, failureMessage, file: file, line: line)
}

private extension Optional {
    var stringValueOrEmpty: String {
        if let unwrapped = self {
            return "\(unwrapped)"
        }
        return ""
    }
}
