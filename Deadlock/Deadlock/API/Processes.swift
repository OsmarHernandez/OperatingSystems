//
//  Processes.swift
//  Deadlock
//
//  Created by Osmar Hernández on 22/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

/**
 * Every process must contain 4 elements that represent the value of Resources
 * R0, R1, R2, R3
 */
class Processes {
    
    /**
     * Allocation matrix variables
     */
    internal static var A_P0 = [0, 0, 1, 2]
    internal static var A_P1 = [2, 0, 0, 0]
    internal static var A_P2 = [0, 0, 3, 4]
    internal static var A_P3 = [2, 3, 5, 4]
    internal static var A_P4 = [0, 3, 3, 2]
    
    /**
     * Claim matrix variables
     */
    internal static var C_P0 = [0, 0, 1, 2]
    internal static var C_P1 = [2, 7, 5, 0]
    internal static var C_P2 = [6, 6, 5, 6]
    internal static var C_P3 = [4, 3, 5, 6]
    internal static var C_P4 = [0, 6, 5, 2]
    
    internal static var availableVector = [2, 1, 0, 0]
    
    /**
     * Update claim matrix value for a single process
     */
    public static func updateProcessResource(_ process: Int, resource: Int, value: Int) {
        switch process {
        case 0:
            C_P0[resource] += value
        case 1:
            C_P1[resource] += value
        case 2:
            C_P2[resource] += value
        case 3:
            C_P3[resource] += value
        case 4:
            C_P4[resource] += value
        default:
            print("Something went wrong updating the value")
        }
        
        print("R\(resource) in P\(process) successfully updated\n")
    }
    
    /**
     * Get the claim matrix
     */
    public static var getClaimMatrix: [[Int]] {
        get {
            return [C_P0, C_P1, C_P2, C_P3, C_P4]
        }
    }
    
    /**
     * Get the allocation matrix
     */
    public static var getAllocationMatrix: [[Int]] {
        get {
            return [A_P0, A_P1, A_P2, A_P3, A_P4]
        }
    }
    
    /**
     * Get available vector
     */
    public static var getAvialableVector: [Int] {
        get {
            return Processes.availableVector
        }
    }
}
