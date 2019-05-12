//
//  main.swift
//  Sempahore
//
//  Created by Osmar Hernández on 11/10/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation

class MyThread {
    static var id = 1
    
    var counter: Int
    var countDown = 5
    var dispatcher: DispatchQueue
    
    init() {
        self.counter = MyThread.id
        dispatcher = DispatchQueue.global()
        
        MyThread.id += 1
    }
    
    func decreaseCounter() {
        if self.countDown > 0 {
            self.countDown -= 1
        }
    }
    
    deinit {
        print("Process has ended")
    }
}

let semaphore = DispatchSemaphore(value: 1)

var thread_1 = MyThread.init()
var thread_2 = MyThread.init()
var thread_3 = MyThread.init()
var thread_4 = MyThread.init()
var thread_5 = MyThread.init()

func asyncOperation(thread: MyThread) {
    thread.dispatcher.async {
        print("P\(thread.counter): semWait")
        semaphore.wait()
        
        print("P\(thread.counter): entering critical section")
        sleep(1)
        print("P\(thread.counter): leaving critical section")
        
        semaphore.signal()
        
        thread.decreaseCounter()
        
        let message = thread.countDown > 0 ? "P\(thread.counter): executing remainder, current countdown = \(thread.countDown)" : "P\(thread.counter) has ended"
        
        print(message)
    }
}

let dispatchGroup = DispatchGroup()

dispatchGroup.enter()

var run = true

while run {
    asyncOperation(thread: thread_1)
    asyncOperation(thread: thread_2)
    asyncOperation(thread: thread_3)
    asyncOperation(thread: thread_4)
    asyncOperation(thread: thread_5)
    
    if thread_1.countDown == 0 &&
        thread_2.countDown == 0 &&
        thread_3.countDown == 0 &&
        thread_4.countDown == 0 &&
        thread_5.countDown == 0 {
        run = false
    }
}

dispatchGroup.leave()

dispatchGroup.notify(queue: DispatchQueue.main) {
    exit(EXIT_SUCCESS)
}

dispatchMain()
