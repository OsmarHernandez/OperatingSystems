//: Playground - noun: a place where people can play

import Foundation

class _Thread {
    
    static var counter = 0
    var number: Int
    var countDown = 5
    var dispatchQueue: DispatchQueue
    
    var startingMessage: (Int) -> String = {
        threadNumber in
        return "Starting thread number => \(threadNumber)"
    }
    
    var currentValueMessage: (Int, Int) -> String = {
        number, countDown in
        return countDown == 0 ? "    - Ending thread number => \(number)" : "    - Task number \(number) ( Current countdown = \(countDown) )"
    }
    
    init() {
        _Thread.counter += 1
        self.number = _Thread.counter
        self.dispatchQueue = DispatchQueue.init(label: "Thread: \(number)")
        print(startingMessage(number), terminator: "\n")
    }
    
    func decrementCountDown() {
        if self.countDown > 0 {
            self.countDown -= 1
        }
        print(self.currentValueMessage(self.number, self.countDown), terminator: "\n")
    }
}

class Process{
    
    var threadsArray = [_Thread]()
    
    let startedMessage = "<< All threads have now been started!!! >>"
    
    func createSomeTasks() {
        for _ in 1...5 {
            let thread = _Thread()
            threadsArray.append(thread)
            print(thread.currentValueMessage(thread.number, thread.countDown), terminator: "\n\n")
            sleep(1)
        }
        print(startedMessage, terminator: "\n\n")
    }
    
    func asyncExecution() {
        threadsArray[0].dispatchQueue.async {
            while self.threadsArray[0].countDown > 0 {
                self.threadsArray[0].decrementCountDown()
            }
        }
        
        threadsArray[1].dispatchQueue.async {
            while self.threadsArray[1].countDown > 0 {
                self.threadsArray[1].decrementCountDown()
            }
        }
        
        threadsArray[2].dispatchQueue.async {
            while self.threadsArray[2].countDown > 0 {
                self.threadsArray[2].decrementCountDown()
            }
        }
        
        threadsArray[3].dispatchQueue.async {
            while self.threadsArray[3].countDown > 0 {
                self.threadsArray[3].decrementCountDown()
            }
        }
        
        threadsArray[4].dispatchQueue.async {
            while self.threadsArray[4].countDown > 0 {
                self.threadsArray[4].decrementCountDown()
            }
        }
    }
}


var mainProcess = Process()

mainProcess.createSomeTasks()

mainProcess.asyncExecution()
