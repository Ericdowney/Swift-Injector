//
//  TestResolvable.swift
//  InjectorTests
//
//  Created by Eric Downey on 7/15/18.
//

import Foundation
import Injector

class TestResolvable: Resolvable {
    var a: Int = 3
    
    init() {
        a = 3
    }
}
