//
//  ReadersAndWriter.swift
//  WriterReader
//
//  Created by Osmar Hernández on 23/10/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class ReadersAndWriter: NSObject {
    
    static var buffer = [Int]()
    
    var writer = Writer()
    var readers = [Reader]()
    
    override init() {
        super.init()
        
        for _ in 0...2 {
            let reader = Reader()
            readers.append(reader)
        }
    }
    
    let x = DispatchSemaphore(value: 1)
    let wSem = DispatchSemaphore(value: 1)
    var readCount = 0
    
    func asyncOperation(writer: Writer? = nil, reader: Reader? = nil) {
        if reader != nil {
            reader?.dispatcher.async {
                while true {
                    self.x.wait()
                    
                    self.readCount += 1
                    print("Read Count: \(self.readCount)")
                    
                    if self.readCount == 1 {
                        self.wSem.wait()
                    }
                    
                    self.x.signal()
                    
                    reader?.readFromBuffer(&ReadersAndWriter.buffer)
                    
                    self.x.wait()
                    
                    self.readCount -= 1
                    print("Read Count: \(self.readCount)")
                    
                    if self.readCount == 0 {
                        self.wSem.signal()
                    }
                    
                    self.x.signal()
                }
            }
        }
        
        if writer != nil {
            writer?.dispatcher.async {
                while true {
                    print("**** Writer: wait operation over wSem ****")
                    self.wSem.wait()
                    
                    print("**** Writer: writing into the buffer ****")
                    writer?.writeInBuffer(&ReadersAndWriter.buffer)
                    print("Buffer: \(ReadersAndWriter.buffer)")
                    
                    print("**** Writer: signal operation over wSem ****")
                    self.wSem.signal()
                }
            }
        }
    }
    
    func execute() {
        asyncOperation(writer: self.writer, reader: nil)
        asyncOperation(writer: nil, reader: self.readers[0])
        asyncOperation(writer: nil, reader: self.readers[1])
        asyncOperation(writer: nil, reader: self.readers[2])
    }
}
