//
//  ThreadSafety2.swift
//  OldConcurrencyLessons
//
//  Created by Gokhan on 31.12.2023.
//

import Foundation

class PrintManager {
    
    private let lock = NSLock()
    private let semaphore = DispatchSemaphore(value: 1)
    
  private func printDocument(name: String) {
       
      semaphore.wait()
    //  lock.lock()
        // Simulate printing time
        Thread.sleep(forTimeInterval: 2)
        print("Printing Document Completed:\(name)")
      
     // lock.unlock()
      
      semaphore.signal()
    }
    
    
    func doTasks() {
        DispatchQueue.concurrentPerform(iterations: 5) { index  in
            let documentName = "Document \(index + 1)"
            printDocument(name: documentName)
        }
    }
}
