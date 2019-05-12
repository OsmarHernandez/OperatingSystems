//
//  Memory.swift
//  LittleManComputer
//
//  Created by Osmar Hernández on 29/08/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation

struct Memory {
    
    var setOfRegisters: [Int]
    
    func load(_ address: Int) -> Int {
        return setOfRegisters[address]
    }
    
    mutating func store(_ value: Int, in address: Int) {
        self.setOfRegisters[address] = value
    }
}
