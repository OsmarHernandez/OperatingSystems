//
//  Reader.swift
//  WriterReader
//
//  Created by Osmar Hernández on 23/10/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class Reader {
    
    static var counter = 1
    
    var id: Int
    var dispatcher: DispatchQueue
    
    init() {
        self.id = Reader.counter
        self.frequencie = 2
        self.dispatcher = DispatchQueue.global()
        
        Reader.counter += 1
    }
    
    var frequencie: Float
    
    func readFromBuffer(_ buffer: inout [Int]) {
        if buffer.count == 0 {
            print("No elements in buffer")
        } else {
            var temporalBuffer = buffer
            
            sleepTask()
            
            temporalBuffer.removeLast()
            buffer = temporalBuffer
            temporalBuffer = []
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
