//
//  ViewController.swift
//  Philosopher
//
//  Created by Osmar Hernández on 09/11/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import QuartzCore
import UIKit

class ViewController: UIViewController {

    var logic: Logic!
    
    let redColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
    let greenColor = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
    let yellowColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
    let purpleColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
    
    let mainQueue = DispatchQueue.global(qos: .userInitiated)
    
    @IBOutlet var forkLabels: [UILabel]!
    @IBOutlet var philosopherLabels: [UILabel]!
    
    var run = false {
        didSet {
            mainQueue.async {
                self.logic.execute(self.run)
                
                while self.run {
                    DispatchQueue.main.async {
                        self.changeColor(philosopher: self.logic.philosophers[0])
                        self.changeColor(philosopher: self.logic.philosophers[1])
                        self.changeColor(philosopher: self.logic.philosophers[2])
                        self.changeColor(philosopher: self.logic.philosophers[3])
                        self.changeColor(philosopher: self.logic.philosophers[4])
                    }
                }
            }
        }
    }
    
    func changeColor(philosopher: Philosopher) {
        if (philosopher.isThinking && !philosopher.isInTheRoom && !philosopher.isEating) {
            philosopherLabels[philosopher.id].backgroundColor = redColor
            
        } else if (philosopher.isThinking && philosopher.isInTheRoom && !philosopher.isEating) {
            philosopherLabels[philosopher.id].backgroundColor = yellowColor
            
        } else if (philosopher.isThinking && philosopher.isInTheRoom && philosopher.isEating) {
            philosopherLabels[philosopher.id].backgroundColor = greenColor
        }
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        run = true
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        run = false
    }
    
    @IBAction func newButton(_ sender: UIButton) {
        run = false
        
        self.logic = Logic()
        
        setup()
        
        for label in philosopherLabels {
            label.backgroundColor = purpleColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setup()
    }
    
    func setup() {
        for index in logic.forks.indices {
            forkLabels[index].text = "Fork: \(index)"
        }
        
        for index in logic.philosophers.indices {
            philosopherLabels[index].text = "Filosofo \n \(index)"
        }
    }
}

