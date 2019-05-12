//
//  ViewController.swift
//  WriterReader
//
//  Created by Osmar Hernández on 22/10/18.
//  Copyright © 2018 Operating Systems. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var logic: ReadersAndWriter!
    
    @IBOutlet var readerLabels: [UILabel]!
    @IBOutlet var sliderValueLabels: [UILabel]!
    
    @IBOutlet weak var readCountLabel: UILabel!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...2 {
            self.readerLabels[i].text = "Lector \(logic.readers[i].id)"
        }
        
        self.main()
    }
    
    func main() {
        // Optionally delete "dispatchGroup"
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        DispatchQueue.global(qos: .background).async {
            self.logic.execute()
            
            while true {
                DispatchQueue.main.async {
                    self.readCountLabel.text = "ReadCount: \(self.logic.readCount) - Buffer: [\(ReadersAndWriter.buffer.count)]"
                }
            }
        }
        
        dispatchGroup.leave()
    }

    @IBAction func generalSlidersListener(_ sender: UISlider) {
        let value = sender.value as NSNumber
        
        switch sender.accessibilityIdentifier! {
        case "writerSlider":
            updateValues(for: sliderValueLabels[0], with: value, writer: logic.writer, reader: nil)
            
        case "firstReaderSlider":
            updateValues(for: sliderValueLabels[1], with: value, writer: nil, reader: logic.readers[0])
            
        case "secondReaderSlider":
            updateValues(for: sliderValueLabels[2], with: value, writer: nil, reader: logic.readers[1])
            
        case "thirdReaderSlider":
            updateValues(for: sliderValueLabels[3], with: value, writer: nil, reader: logic.readers[2])
            
        default:
            print("Should not happen")
        }
    }
    
    func updateValues(for label: UILabel, with value: NSNumber, writer: Writer? = nil, reader: Reader? = nil) {
        label.text = "\(numberFormatter.string(from: value)!)"
        
        if let writer = writer {
            writer.frequencie = value as! Float
        }
        
        if let reader = reader {
            reader.frequencie = value as! Float
        }
    }
}

