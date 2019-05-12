//
//  LittleManComputer.swift
//  LittleManComputer
//
//  Created by Osmar Hernández on 29/08/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation

class LittleManComputer {
    
    static let shared = LittleManComputer()
    
    // Set the input to a value only for demo
    var input: Int?
    var memory = Memory(setOfRegisters: [Int](repeating: 0, count: 100))
    private var instructionCounter = InstructionCounter(counter: 0)
    private var calculator = Calculator(acumulator: 0)
    private var execute = true
    
    private enum Operation {
        case add, sub
        case sto, sta, load
        case branch, branchz, branchp
        case input, output
    }
    
    private let operations: Dictionary<Int, Operation> = [
        1 : Operation.add,
        2 : Operation.sub,
        3 : Operation.sto,
        4 : Operation.sta,
        5 : Operation.load,
        6 : Operation.branch,
        7 : Operation.branchz,
        8 : Operation.branchp,
        901 : Operation.input,
        902 : Operation.output
    ]
    
    private func performOperation(opcode msbit: Int, address lsbits: Int?) {
        if let operation = operations[msbit] {
            switch operation {
            case .add:
                let value = memory.load(lsbits!)
                calculator.add(value)
                self.instructionCounter.increment()
            case .sub:
                let value = memory.load(lsbits!)
                calculator.sub(value)
                self.instructionCounter.increment()
            case .sto:
                let value = calculator.acumulator
                memory.store(value, in: lsbits!)
                //                self.calculator.acumulator = 0
                self.instructionCounter.increment()
            case .sta:
                print("No le entiendo a esta instruccion")
                self.instructionCounter.increment()
            case .load:
                let value = memory.load(lsbits!)
                calculator.acumulator = value
                self.instructionCounter.increment()
            case .branch:
                instructionCounter.branch(to: lsbits!)
            case .branchz:
                if calculator.acumulator == 0 {
                    instructionCounter.branch(to: lsbits!)
                } else {
                    self.instructionCounter.increment()
                }
            case .branchp:
                if calculator.acumulator >= 0 {
                    instructionCounter.branch(to: lsbits!)
                } else {
                    self.instructionCounter.increment()
                }
            case .input:
                if input != nil {
                    calculator.acumulator = input!
                }
                self.instructionCounter.increment()
            case .output:
                output = calculator.acumulator
                print(output!)
                self.instructionCounter.increment()
            }
        }
    }
    
    public func reset() {
        self.memory = Memory(setOfRegisters: [Int](repeating: 0, count: 100))
        self.instructionCounter.counter = 0
        self.calculator.acumulator = 0
    }
    
    public func run() {
        while execute {
            let address = instructionCounter.counter
            let instruction = memory.load(address)

            decode(instruction)
        }
        
        self.execute = true
    }
    
    private func decode(_ instruction: Int) {
        switch instruction {
        case 0:
            execute = false
        case 901, 902:
            performOperation(opcode: instruction, address: nil)
        default:
            let msbit = instruction / 100
            let lsbit = instruction - (msbit * 100)
            
            performOperation(opcode: msbit, address: lsbit)
        }
    }
    
    public var output: Int?
}
