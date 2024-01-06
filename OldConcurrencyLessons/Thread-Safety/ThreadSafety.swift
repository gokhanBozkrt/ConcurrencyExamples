//
//  ThreadSafety.swift
//  OldConcurrencyLessons
//
//  Created by Gokhan on 31.12.2023.
//


//MARK: Thread Safety - Synchronization

import Foundation


/* 
 
 NSLock -> Blocks
 Semaphore -> Blok mode wait, await mode timeout 
 

*/

class Counter {
    
    var count = 0 // Shared resource accessed by 2 threads
    
    let lock = NSLock()
    
    let semaphores = DispatchSemaphore(value: 1) // Only one thread can acces shared resource at a time
    
    func increment() {
        
      //  lock.lock()
        
        semaphores.wait()
        
        count += 1 // Shared Resource
        print("Incremented count: \(count)")
        
       // lock.unlock()
        
        semaphores.signal()
    }
    
    func decrement() {
        
       // lock.lock()
        
        semaphores.wait()
        
        count -= 1 // Shared Resource
        print("Decremented count: \(count)")
        
       // lock.unlock()
        
        semaphores.signal()
    }
    
    func doTasks() {
        count = 0
        
        DispatchQueue.concurrentPerform(iterations: 10) { _ in // Thread 1
            increment()
        }
        
        DispatchQueue.concurrentPerform(iterations: 5) { _ in // Thread 2
            decrement()
        }
    
        print("Final value: \(count)")
        
       
    }
}
