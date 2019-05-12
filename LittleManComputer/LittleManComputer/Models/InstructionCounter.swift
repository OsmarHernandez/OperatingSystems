//
//  InstructionCounter.swift
//  LittleManComputer
//
//  Created by Osmar Hernández on 29/08/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation

struct InstructionCounter {
    var counter: Int
    
    mutating func increment() {
        self.counter += 1
    }
    
    mutating func branch(to address: Int) {
        self.counter = address
    }
}
