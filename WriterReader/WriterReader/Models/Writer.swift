//
//  Writer.swift
//  WriterReader
//
//  Created by Osmar Hernández on 23/10/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class Writer {
    
    var frequencie: Float
    var dispatcher: DispatchQueue
    
    init() {
        self.frequencie = 9
        self.dispatcher = DispatchQueue.global()
    }
    
    func writeInBuffer(_ buffer: inout [Int]) {
        if buffer.count > 100 {
            print("There's no space in buffer")
        } else {
            var temporalBuffer = buffer
            let randomNumber = Int(arc4random_uniform(UInt32(10)))
            
            sleepTask()
            
            temporalBuffer.append(randomNumber)
            buffer = temporalBuffer
        }
    }
    
    func getSleepTime(from value: Float) -> Double {
        var sameValue = value
        sameValue *= 1000
        
        let time = 10000 - Double(sameValue)
        
        return time / 1000
    }
    
    func sleepTask() {
        let time = getSleepTime(from: self.frequencie)
        
        sleep(UInt32(time))
    }
}
