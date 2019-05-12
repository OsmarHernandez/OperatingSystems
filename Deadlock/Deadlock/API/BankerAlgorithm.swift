//
//  BankerAlgorithm.swift
//  Deadlock
//
//  Created by Osmar Hernández on 23/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class BankerAlgorithm {
    
    /**
     * Finish the program if the is no a safe state
     */
    public static var finishProgram = false
    
    /**
     * Simulation of allocated resources
     * Does the substraction of Claim Matrix - Allocation Matrix
     *  if the substraction of thos matrix makes a process = [0, 0, 0, 0]
     *  the algorithm ends and the resources of the process are added to the
     *  'available vector'
     */
    public static func simulateAllocatedResources(_ claimMatrix: [[Int]], _ allocationMatrix: [[Int]]) {
        var process = [Int]()
        var matrix = [[Int]]()
        var safeState = false
        
        /**
         * @cmRow: claim matrix row
         * @amRow: allocation matrix row
         */
        for (cmRow, amRow) in zip(claimMatrix, allocationMatrix) where amRow != [0, 0, 0, 0] {
            
            /**
             * @cmIndex: claim matrix index
             * @amIndex: allocation matrix index
             */
            for (cmIndex, amIndex) in zip(cmRow.indices, amRow.indices) {
                var resource = 0
                
                if cmRow[cmIndex] > amRow[amIndex] {
                    resource = cmRow[cmIndex] - amRow[amIndex]
                }
                
                process.append(resource)
            }
            
            /**
             * If all the resources in a process are equal to zero, there is a safe state so
             *  the process resources can be overwritten
             */
            if process == [0, 0, 0, 0] {
                safeState = true
            } else {
                /**
                 * If the process - available vector is equal to zero, there is a safe state so
                 *  the process resources can be overwritten
                 */
                var processMinusAvailableVector = [Int]()
                
                for index in process.indices {
                    var resource = 0
                    
                    if process[index] > Processes.availableVector[index] {
                        resource = process[index] - Processes.availableVector[index]
                    }
                    
                    processMinusAvailableVector.append(resource)
                }
                
                if processMinusAvailableVector == [0, 0, 0, 0] { safeState = true }
            }
            
            /**
             * The allocation matrix and claim matrix variables are overwritten
             */
            if safeState {
                overwriteProcessAndAvailableVector(amRow)
                break
            }
            
            matrix.append(process)
            process = []
        }
        
        /**
         * If every process has been iterated but there is no a safe state, finish program
         */
        if !safeState {
            BankerAlgorithm.finishProgram = true
        }
    }
    
    /**
     * Overwrite claim and allocation variables and updates availableVector
     */
    private static func overwriteProcessAndAvailableVector(_ allocationResources: [Int]) {
        updateAvailableVector(allocationResources)
        
        switch allocationResources {
        case Processes.A_P0:
            Processes.A_P0 = [0, 0, 0, 0]
            Processes.C_P0 = [0, 0, 0, 0]
            print("Process 0 completed...\n")
            
        case Processes.A_P1:
            Processes.A_P1 = [0, 0, 0, 0]
            Processes.C_P1 = [0, 0, 0, 0]
            print("Process 1 completed...\n")
            
        case Processes.A_P2:
            Processes.A_P2 = [0, 0, 0, 0]
            Processes.C_P2 = [0, 0, 0, 0]
            print("Process 2 completed...\n")
            
        case Processes.A_P3:
            Processes.A_P3 = [0, 0, 0, 0]
            Processes.C_P3 = [0, 0, 0, 0]
            print("Process 3 completed...\n")
            
        case Processes.A_P4:
            Processes.A_P4 = [0, 0, 0, 0]
            Processes.C_P4 = [0, 0, 0, 0]
            print("Process 4 completed...\n")
            
        default:
            print("Error overwriting process and available vector")
        }
    }
    
    /**
     * Update the available vector
     */
    private static func updateAvailableVector(_ processResources: [Int]) {
        
        for index in processResources.indices {
            Processes.availableVector[index] += processResources[index]
        }
    }
}
