//
//  Calculator.swift
//  LittleManComputer
//
//  Created by Osmar Hernández on 29/08/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation

struct Calculator {
    var acumulator: Int
    
    mutating func add(_ value: Int) {
        self.acumulator += value
    }
    
    mutating func sub(_ value: Int) {
        self.acumulator -= value
    }
}
