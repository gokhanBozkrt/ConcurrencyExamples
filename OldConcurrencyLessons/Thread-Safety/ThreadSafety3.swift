//
//  ThreadSafety3.swift
//  OldConcurrencyLessons
//
//  Created by Gokhan on 6.01.2024.
//

import Foundation

class Permitter {
    
    let semaphore = DispatchSemaphore(value: 0)
    
    func doPermitTask() {
        
        DispatchQueue.global().async { // Thread 1
            print("Thread 1 waiting for a permit")
            
            let timeoutResult = self.semaphore.wait(timeout: .now() + 2)
            
            if timeoutResult == .success {
                print("Thread 1 acquired a permit")
            } else {
                print("Thread 1 timeout while waiting for a permit")
            }
            
            self.semaphore.signal()
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { // Thread 2
            print("Thread 2 is relasing a permit")
            
            self.semaphore.signal()
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { // Thread 3
            print("Thread 3 trying to  acquire a permit")
            
            let result = self.semaphore.wait(timeout: .now() + 1) // Non-Blocking timeout
            
            if result == .success {
                print("Thread 3 acquired a permit")
            } else {
                print("Thread 3 timeout while waiting for a permit")
            }
            
            print("Counting without Resource...")
        }
        
    }
}
