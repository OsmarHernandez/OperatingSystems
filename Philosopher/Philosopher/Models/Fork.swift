//
//  Fork.swift
//  Philosopher
//
//  Created by Osmar Hernández on 09/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class Fork {
    
    // Type property that's going to be used to take control of the current id
    private static var counter = 0
    
    // Indicates the fork id, can be used to see which forks is a philosopher using to eat
    public let id: Int
    
    // Binary semaphore that indicates whether the fork is available or not.
    public let available = DispatchSemaphore(value: 1)
    
    // Initializing the fork
    init() {
        self.id = Fork.counter
        
        Fork.counter += 1
    }
    
    // Every time the object is deallocated from memory, the type property is going to be reseted
    deinit {
        Fork.counter = 0
    }
}
