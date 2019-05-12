//
//  Logic.swift
//  Philosopher
//
//  Created by Osmar Hernández on 09/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class Logic {

    // forks - shared resources
    private (set) var forks = [Fork]()
    
    // philosophers
    private (set) var philosophers = [Philosopher]()
    
    // Initializing 5 forks and 5 philosophers
    init() {
        for _ in 1...5 {
            let fork = Fork()
            forks.append(fork)
            
            let philosopher = Philosopher()
            philosophers.append(philosopher)
        }
    }
    
    /*
     * Initializing the semaphore with a value of 4
     *  The idea is to limit the access of how many philosophers should enter the dining room so at least
     *  two of them can be able to use the shared resources in a safety way and allow them to perform
     *  their eating action
     */
    private var roomSemaphore = DispatchSemaphore(value: 4)
    
    // Asynchronous function that will let any philosopher take the shared resources of the program
    private func asyncOperation(philosopher: Philosopher) {
        philosopher.dispatcher.async {
            while true {
                // Thinking
                philosopher.think()
                sleep(1)
                
                // Room access
                self.roomSemaphore.wait()
                philosopher.enter()
                sleep(1)
                
                // Taking forks
                self.forks[philosopher.id].available.wait()
                self.forks[(philosopher.id + 1) % 5].available.wait()
                
                // Eating
                philosopher.eat()
                sleep(1)
                
                // Leaving the forks
                self.forks[(philosopher.id + 1) % 5].available.signal()
                self.forks[philosopher.id].available.signal()
                
                // Leaving the room
                self.roomSemaphore.signal()
                philosopher.leave()
            }
        }
    }
    
    // Executes the actions that a philosopher can do
    public func execute(_ run: Bool) {
        asyncOperation(philosopher: philosophers[0])
        asyncOperation(philosopher: philosophers[1])
        asyncOperation(philosopher: philosophers[2])
        asyncOperation(philosopher: philosophers[3])
        asyncOperation(philosopher: philosophers[4])
    }
    
    // Every time the object is deallocated from memory, the forks and philosophers array are
    // going to be reseted
    deinit {
        print("Deleting current simulation")
    }
}
