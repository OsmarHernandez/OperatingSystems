//
//  main.swift
//  SyncVsAsync
//
//  Created by Osmar Hernández - Jesús Sierra on 14/09/18.
//  Copyright © 2018 Osmar Hernández - Jesús Sierra. All rights reserved.
//
import Foundation
import QuartzCore

let constants = Constants()
let requestAPI = RequestAPI()

// Used to measure the time of both function calls
func executionTimeInterval(block: () -> ()) -> CFTimeInterval {
    let start = CACurrentMediaTime()
    block();
    let end = CACurrentMediaTime()
    return end - start
}

func synchronousRequest() {
    let syncRequest = executionTimeInterval {
        requestAPI.webSyncRequest(constants.fifa)
        requestAPI.webSyncRequest(constants.uber)
        requestAPI.webSyncRequest(constants.ngag)
        requestAPI.webSyncRequest(constants.apple)
        requestAPI.webSyncRequest(constants.gmail)
        
        requestAPI.webSyncRequest(constants.yahoo)
        requestAPI.webSyncRequest(constants.disney)
        requestAPI.webSyncRequest(constants.flickr)
        requestAPI.webSyncRequest(constants.google)
        requestAPI.webSyncRequest(constants.reddit)
        
        requestAPI.webSyncRequest(constants.tinder)
        requestAPI.webSyncRequest(constants.tumblr)
        requestAPI.webSyncRequest(constants.netflix)
        requestAPI.webSyncRequest(constants.samsung)
        requestAPI.webSyncRequest(constants.twitter)
        
        requestAPI.webSyncRequest(constants.youtube)
        requestAPI.webSyncRequest(constants.facebook)
        requestAPI.webSyncRequest(constants.instagram)
        requestAPI.webSyncRequest(constants.microsoft)
        requestAPI.webSyncRequest(constants.piktochart)
    }
    
    print("Synchronous Request Time: \(syncRequest)")
}

func asynchronousRequest() {
    let asyncRequest = executionTimeInterval {
        requestAPI.webAsyncRequest(constants.fifa)
        requestAPI.webAsyncRequest(constants.uber)
        requestAPI.webAsyncRequest(constants.ngag)
        requestAPI.webAsyncRequest(constants.apple)
        requestAPI.webAsyncRequest(constants.gmail)
        
        requestAPI.webAsyncRequest(constants.yahoo)
        requestAPI.webAsyncRequest(constants.disney)
        requestAPI.webAsyncRequest(constants.flickr)
        requestAPI.webAsyncRequest(constants.google)
        requestAPI.webAsyncRequest(constants.reddit)
        
        requestAPI.webAsyncRequest(constants.tinder)
        requestAPI.webAsyncRequest(constants.tumblr)
        requestAPI.webAsyncRequest(constants.netflix)
        requestAPI.webAsyncRequest(constants.samsung)
        requestAPI.webAsyncRequest(constants.twitter)
        
        requestAPI.webAsyncRequest(constants.youtube)
        requestAPI.webAsyncRequest(constants.facebook)
        requestAPI.webAsyncRequest(constants.instagram)
        requestAPI.webAsyncRequest(constants.microsoft)
        requestAPI.webAsyncRequest(constants.piktochart)
    }
    
    print("Asynchronous Request Time: \(asyncRequest)")
}

print()

synchronousRequest()
asynchronousRequest()

print()

dispatchMain()
