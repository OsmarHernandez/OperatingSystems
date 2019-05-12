//
//  InstructionsViewController.swift
//  LittleManComputer
//
//  Created by Osmar Hernández on 31/08/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import UIKit

class InstructionsViewController: UITableViewController {
    
    let formats = [
        "1xx",
        "2xx",
        "3xx",
        "4xx",
        "5xx",
        "6xx",
        "7xx",
        "8xx",
        "901",
        "902"
    ]
    
    let mnemonics = [
        "Add",
        "Sub",
        "Sto",
        "Sta",
        "Load",
        "Branch",
        "Branchz",
        "Branchp",
        "Input",
        "Output"
    ]
    
    let meanings = [
        "Adds the contents of mailbox xx to the calculator display.",
        "Substracts the contents of mailbox xx to the calculator display.",
        "Stores the calculator value into mailbox xx",
        "Stores the address portion of the calculator value into mailbox xx",
        "Loads the contents of mailbox xx into the calculator",
        "Set the instruction counter to number xx, branching to mailbox xx",
        "If the calculator value is zero, branch to mailbox xx",
        "If the calculator is positive, branch to mailbox xx",
        "Read number from the IN basket and key it into the calculator",
        "Copy the number in the calculator and place it into the OUT basket"
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mnemonics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "instructionCell") as! MnemonicTableViewCell
        
        cell.formatLabel.text = formats[indexPath.row]
        cell.mnemonicLabel.text = mnemonics[indexPath.row]
        cell.meaningLabel.text = meanings[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Instructions"
    }
}
