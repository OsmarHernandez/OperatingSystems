//: Activity 9 - Random Threads

import Foundation

// Extending Array to retrieve a value by index and remove it from array
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

// Creating my own threads
class OwnThread {
    
    static var ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var id: Int
    var dispatchQueue: DispatchQueue
    
    init() {
        let randomIndex = Int(arc4random_uniform(UInt32(OwnThread.ids.count)))
        self.id = OwnThread.ids.pop(randomIndex)!
        self.dispatchQueue = DispatchQueue.init(label: "Thread: \(id)")
    }
    
    deinit {
        OwnThread.ids.append(self.id)
        print("Thread \(self.id) has been killed")
    }
}

var threads = [OwnThread]()

for _ in 1...10 {
    let thread = OwnThread()
    threads.append(thread)
}

for thread in threads {
    print("Thread: \(thread.id)")
}
