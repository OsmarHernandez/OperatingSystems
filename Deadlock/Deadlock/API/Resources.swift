//
//  Resources.swift
//  Deadlock
//
//  Created by Osmar Hernández on 22/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class Resources {
    
    /**
     * Every resource has an specific Int value
     * An array of this values is what we know as the 'resource vector'
     */
    private static let R0 = 6
    private static let R1 = 7
    private static let R2 = 12
    private static let R3 = 12
    
    /**
     * Get the resource vector
     */
    public static var getResourceVector: [Int] {
        get {
            return [R0, R1, R2, R3]
        }
    }
}
