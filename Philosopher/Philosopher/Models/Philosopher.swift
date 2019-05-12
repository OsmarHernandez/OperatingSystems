//
//  Philosopher.swift
//  Philosopher
//
//  Created by Osmar Hernández on 09/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

/**
 * Should be able to eat
 * Must take its left fork first and then the second one
 */
class Philosopher {
    
    // Type property that's going to be used to take control of the current id
    private static var counter = 0
    
    // Indicates the philosopher
    public let id: Int
    
    // Internal varialbles that controls the action of the philosopher
    private (set) var isEating = false
    private (set) var isThinking = false
    private (set) var isInTheRoom = false
    
    // Creating a dispatch queue with high priority to execute code in a background thread
    private (set) var dispatcher: DispatchQueue
    
    // Initializing the philosopher
    init() {
        self.id = Philosopher.counter
        self.dispatcher = DispatchQueue.global(qos: .userInteractive)
        
        Philosopher.counter += 1
    }
    
    // Actions that the philosopher can do
    public func enter() {
        print("Philosopher \(self.id) enters dining room")
        self.isInTheRoom = true
    }
    
    public func eat() {
        print("Philosopher \(self.id) eating")
        self.isEating = true
    }
    
    public func think() {
        print("Philosopher \(self.id) thinking")
        self.isThinking = true
    }
    
    public func leave() {
        print("Philosopher \(self.id) leaves dining room")
        self.isEating = false
        self.isThinking = false
        self.isInTheRoom = false
    }
    
    // Every time the object is deallocated from memory, the type property is going to be reseted
    deinit {
        Philosopher.counter = 0
    }
}
