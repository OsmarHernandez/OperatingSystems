//
//  Extension.swift
//  SynchronizingTask
//
//  Created by Osmar Hernández on 19/09/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import Foundation

// Extended array to retrieve value depending of the index
extension Array where Iterator.Element == Int {
    mutating func pop(_ index: Int) -> Int? {
        var number: Int?
        
        if self.count > 0 {
            number = self[index]
            self.remove(at: index)
        } else {
            number = nil
        }
        return number
    }
}
