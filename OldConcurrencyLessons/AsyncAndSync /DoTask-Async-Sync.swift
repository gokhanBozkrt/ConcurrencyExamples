//
//  DoTask-Async-Sync.swift
//  OldConcurrencyLessons
//
//  Created by Gökhan Bozkurt on 17.11.2023.
//

import Foundation


class DoTasksAsyncAndSync {
    // 1. GCD
    func syncGCD() {
        DispatchQueue.global().sync {
               print("SYNC- GCD")
        }
        print("I need to wait for SYNC GCD")
    }
    
    func asyncGCD() {
        DispatchQueue.global().async {
               print("ASYNC- GCD")
        }
        print("I dont need to wait for ASYNC GCD")
    }
    
    // 2. Operation Queue
    
    func asyncOperationQueue() {
         let operationQueue = OperationQueue()
        
        let asyncBlockOperation = BlockOperation {
        print("ASYNC  OPQ")
        }
        operationQueue.addOperation(asyncBlockOperation)
        
        print("I dont need to wait for async OPQ")
    }
    
    func syncOperationQueue() {
         let operationQueue = OperationQueue()
        
        let syncBlockOperation1 = BlockOperation {
        print("SYNC1  OPQ")
        }
        let syncBlockOperation2 = BlockOperation {
        print("SYNC2  OPQ")
        }
        operationQueue.addOperations([syncBlockOperation1,syncBlockOperation2], waitUntilFinished: true)
        
        print("I  need to wait for sync OPQ")
    }
    
    // 3. Completion Handlers
    
    func fetchSomeDataAsyncCH(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            completion()
        }
    }
    
    func asyncTaskCompletionHandler() {
        fetchSomeDataAsyncCH {
            print("Completed async task with completion handler")
        }
        print("I dont need to wait")
    }
    /////////////////////////
    func fetchSomeDataSyncCH(completion: () -> Void) {
            completion()
    }
    
    func syncTaskCompletionHandler() {
        fetchSomeDataSyncCH {
            print("Completed sync task with completion handler")
        }
        print("I do need to wait")
    }
    
}
