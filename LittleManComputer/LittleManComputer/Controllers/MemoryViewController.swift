//
//  MemoryViewController.swift
//  LittleManComputer
//
//  Created by Osmar Hernández on 31/08/18.
//  Copyright © 2018 Osmar Hernández. All rights reserved.
//

import UIKit

class MemoryViewController: UITableViewController {
 
    var littleMan: LittleManComputer!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return littleMan.memory.setOfRegisters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address", for: indexPath) as! AddressTableViewCell

        cell.addressLabel.text = "Address: \(indexPath.row)"
        cell.valueTextField.text = "\(littleMan.memory.setOfRegisters[indexPath.row])"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressCell = tableView.cellForRow(at: indexPath) as! AddressTableViewCell
        
        if let value = Int(addressCell.valueTextField.text!), value != 0 {
            littleMan.memory.store(value, in: indexPath.row)
        }
    }
}

extension MemoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
