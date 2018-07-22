//
//  XCTAssertEmpty.swift
//  InjectorTests
//
//  Created by Eric Downey on 7/15/18.
//

import XCTest

func XCTAssertEmpty<Element>(_ expression: [Element], _ message: String? = nil, _ file: StaticString = #file, _ line: UInt = #line) {
    let failureMessage = message ?? "The given expression \(expression) is not empty"
    XCTAssertEqual(expression.count, 0, failureMessage, file: file, line: line)
}
