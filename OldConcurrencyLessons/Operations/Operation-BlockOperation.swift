//
//  Operation-BlockOperation.swift
//  OldConcurrencyLessons
//
//  Created by Gökhan Bozkurt on 20.11.2023.
//

import Foundation

class ServiceOperation: Operation {
    var message = ""
    
    override func main() {
        print("Operation Subclass - \(message)")
    }
    
}


class Operations {
    let queue = OperationQueue()
    
    func operationExample() {
        let operation1 = ServiceOperation()
        operation1.message = "op-1"
        
        let operation2 = ServiceOperation()
        operation2.message = "op-2"
    
        operation1.addDependency(operation2)
        
        queue.addOperation(operation1)
        queue.addOperation(operation2)
    }
    
    func blockOperationExample() {
        let blockOperation = BlockOperation {
            print("Block Operation")
        }
        
        queue.addOperation(blockOperation)
    }
}
