//
//  MainViewController.swift
//  LittleManComputer
//
//  Created by Osmar Hernández on 30/08/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import UIKit
import FontAwesome

class MainViewController: UIViewController {

    var littleMan: LittleManComputer!
    
    @IBOutlet weak var barsButton: UIButton!
    @IBOutlet weak var memoryButton: UIButton!
    @IBOutlet weak var codeButton: UIButton!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var inOutBasket: UITextField!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    @IBAction func resetAction(_ sender: UIBarButtonItem) {
        littleMan.reset()
        
        inOutBasket.text = nil
    }
    
    @IBAction func barsBAction(_ sender: UIButton) {
        // Only for testing
        //  let instructions = [901, 340, 901, 341, 541, 713, 542, 140, 342, 541, 243, 341, 604, 542, 902]
        
        let instructions = [901, 313, 214, 805, 611, 514, 902, 115, 314, 513, 602]
        
        for (key, value) in instructions.enumerated() {
            littleMan.memory.store(value, in: key)
        }
        
        littleMan.memory.store(1, in: 14)
        littleMan.memory.store(1, in: 15)
//        littleMan.memory.store(1, in: 43)
    }
    
    @IBAction func execute(_ sender: UIButton) {
        let value = inOutBasket.text
        
        if let integerValue = Int(value!) {
            littleMan.input = integerValue
        }
        
        littleMan.run()

        if let result = littleMan.output {
            inOutBasket.text = "\(result)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doneEnabler()
        buttonsSetup()
    }
    
    func doneEnabler() {
        // Enable done key for number pad
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.done))
        
        toolBar.setItems([doneButton], animated: false)
        
        inOutBasket.inputAccessoryView = toolBar
    }
    
    func buttonsSetup() {
        // Setting up the buttons
        barsButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        barsButton.setTitle(String.fontAwesomeIcon(name: .bars), for: .normal)
        
        codeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        codeButton.setTitle(String.fontAwesomeIcon(name: .code), for: .normal)
        
        memoryButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        memoryButton.setTitle(String.fontAwesomeIcon(name: .memory), for: .normal)
        
        runButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        runButton.setTitle(String.fontAwesomeIcon(name: .terminal), for: .normal)
    }
    
    @objc func done() {
        view.endEditing(true)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        
        if let memoryViewController = destinationViewController as? MemoryViewController {
            memoryViewController.littleMan = littleMan
        }
    }
}
