//
//  Program.swift
//  Deadlock
//
//  Created by Osmar Hernández on 22/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

class Program {
    public static var run = true
    
    public static func execute(_ input: String) {
        
        /**
         * Print matrix
         */
        func printMatrix(_ matrix: [[Int]]) {
            for row in matrix {
                print(row)
            }
            
            print()
        }
        
        /**
         * Get program matrix status
         */
        func getMatrixStatus() {
            print("Claim Matrix")
            printMatrix(Processes.getClaimMatrix)
            
            print("Allocation Matrix")
            printMatrix(Processes.getAllocationMatrix)
            
            print("Available Vector")
            print(Processes.getAvialableVector)
            print()
            
            print("Resource Vector")
            print(Resources.getResourceVector)
            print()
        }
        
        /**
         * Updates resource x for process x
         */
        func updateMethod() {
            var loop = true
            
            while loop {
                print("Enter process number...")
                
                if let process = Int(readLine()!) {
                    print("Enter resource number...")
                    
                    if let resource = Int(readLine()!) {
                        print("Enter value to add to R\(resource) for P\(process)...")
                        
                        if let value = Int(readLine()!) {
                            Processes.updateProcessResource(process, resource: resource, value: value)
                            
                            loop = false
                        }
                    }
                }
            }
        }
        
        /**
         * Execute Banker algorithm
         */
        func runMethod() {
            print("Running...\n")
            
            while Processes.getAvialableVector != Resources.getResourceVector && !BankerAlgorithm.finishProgram {
                BankerAlgorithm.simulateAllocatedResources(Processes.getClaimMatrix, Processes.getAllocationMatrix)
                getMatrixStatus()
                
                if BankerAlgorithm.finishProgram {
                    print("Not Safe program")
                }
            }
            
            Program.run = false
        }
        
        /**
         * Exit Program
         */
        func exitMethod() {
            print("Exit...\n")
            
            run = false
        }
        
        /**
         * Menu options
         */
        switch input {
        case "Update":
            updateMethod()
        case "Status":
            getMatrixStatus()
        case "Run":
            runMethod()
        case "Exit":
            exitMethod()
        default:
            print("Please type a valid option")
        }
    }
}
