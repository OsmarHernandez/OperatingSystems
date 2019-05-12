//
//  main.swift
//  Deadlock
//
//  Created by Osmar Hernández on 22/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import Foundation

var input: String?
let message = """
                Instructions:
                    Type 'Update' to change a process resource value
                    Type 'Status' to get program status
                    Type 'Run' to run the program
                    Type 'Exit' to exit the program
              """

while Program.run {
    print(message)

    input = readLine()

    if let input = input {
        Program.execute(input)
    }
}
