//
//  RequestAPI.swift
//  SyncVsAsync
//
//  Created by Osmar Hernández - Jesús Sierra on 17/09/18.
//  Copyright © 2018 Osmar Hernández - Jesús Sierra. All rights reserved.
//

import Foundation

struct RequestAPI {
    
    func webSyncRequest(_ tuple: (id: Int, stringURL: String)) {
        let stringURL = "https://" + tuple.stringURL
        let url = URL(string: stringURL)!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            let result = String(data: data!, encoding: String.Encoding.utf8) ?? "Error decoding \(stringURL) website"
            
            let message = error == nil ? "Correctly read \(result.count) characters from \(stringURL) website" : result
            
            DispatchQueue.main.sync {
                print("     - Synchronous Task:")
                print("ID \(tuple.id): \(message)", terminator: "\n")
            }
        }
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).sync {
            task.resume()
        }
    }
    
    func webAsyncRequest(_ tuple: (id: Int, stringURL: String)) {
        let stringURL = "https://" + tuple.stringURL
        let url = URL(string: stringURL)!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            let result = String(data: data!, encoding: String.Encoding.utf8) ?? "Error decoding \(stringURL) website"
            
            let message = error == nil ? "Correctly read \(result.count) characters from \(stringURL) website" : result
            
            DispatchQueue.main.async {
                print("     - Asynchronous Task:")
                print("ID \(tuple.id): \(message)", terminator: "\n")
            }
        }
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            task.resume()
        }
    }
}
