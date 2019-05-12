//
//  main.swift
//  SynchronizingTask
//
//  Created by Osmar Hernández on 19/09/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation


// TODO: Implement deinit
var threads = [OwnThread?]()

// Create 10 threads
for _ in 1...10 {
    let thread: OwnThread? = OwnThread()
    threads.append(thread)
}

let dispatchGroup = DispatchGroup()

dispatchGroup.enter()

// Asynchronously try to kill each thread, shared variable: OwnThread.ids
while OwnThread.ids.count != 10 {
    
    threads[0]?.dispatchQueue.async {
        if threads[0]!.kill() {
            print("Thread \(threads[0]!.id) killed")
        }
    }

    threads[1]?.dispatchQueue.async {
        if threads[1]!.kill() {
            print("Thread \(threads[1]!.id) killed")
        }
    }
    
    threads[2]?.dispatchQueue.async {
        if threads[2]!.kill() {
            print("Thread \(threads[2]!.id) killed")
        }
    }
    
    threads[3]?.dispatchQueue.async {
        if threads[3]!.kill() {
            print("Thread \(threads[3]!.id) killed")
        }
    }
    
    threads[4]?.dispatchQueue.async {
        if threads[4]!.kill() {
            print("Thread \(threads[4]!.id) killed")
        }
    }
    
    threads[5]?.dispatchQueue.async {
        if threads[5]!.kill() {
            print("Thread \(threads[5]!.id) killed")
        }
    }
    
    threads[6]?.dispatchQueue.async {
        if threads[6]!.kill() {
            print("Thread \(threads[6]!.id) killed")
        }
    }
    
    threads[7]?.dispatchQueue.async {
        if threads[7]!.kill() {
            print("Thread \(threads[7]!.id) killed")
        }
    }
    
    threads[8]?.dispatchQueue.async {
        if threads[8]!.kill() {
            print("Thread \(threads[8]!.id) killed")
        }
    }
    
    threads[9]?.dispatchQueue.async {
        if threads[9]!.kill() {
            print("Thread \(threads[9]!.id) killed")
        }
    }
}

dispatchGroup.leave()

dispatchGroup.notify(queue: DispatchQueue.main) {
    exit(EXIT_SUCCESS)
}
dispatchMain()
