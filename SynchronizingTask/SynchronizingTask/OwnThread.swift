//
//  OwnThread.swift
//  SynchronizingTask
//
//  Created by Osmar Hernández on 19/09/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation

// Swift threads are a little bit different, to simulate the same behaviour as taught by the professor in class this class should be used
class OwnThread {
    
    static var ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]    // Used for the id
    var id: Int
    var dispatchQueue: DispatchQueue
    
    init() {
        let randomIndex = Int(arc4random_uniform(UInt32(OwnThread.ids.count)))  // Generate random number
        self.id = OwnThread.ids.pop(randomIndex)!   // randomly assign a value from the ids array
        self.dispatchQueue = DispatchQueue.init(label: "Thread: \(id)") // used to make a task asynchronously
    }

    // This method simulates the "kill" of the thread
    func kill() -> Bool {
        var result = Bool()
        
        switch self.id {
        case 1:
            if OwnThread.ids.count == 0 {
                OwnThread.ids.append(self.id)
                result = true
            } else {
                return false
            }
        case 2...10:
            if OwnThread.ids.count > 0, self.id - OwnThread.ids.last! == 1 {
                OwnThread.ids.append(self.id)
                result = true
            } else if !OwnThread.ids.contains(self.id) {
                print("Thread \(self.id) waiting for thread \(self.id - 1) to be killed")
                result = false
            } else {
                result = false
            }
        default:
            print("Something...")
        }
        
        return result
    }
}
