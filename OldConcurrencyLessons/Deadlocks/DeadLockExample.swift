//
//  DeadLockExample.swift
//  OldConcurrencyLessons
//
//  Created by Gokhan on 7.01.2024.
//

import Foundation

/*
 A deadlock is a situation in concurrent programming where two or more tasks or threads are blocked indefinitely,waiting for each other to complete.
 
 Deadlocks can occur when tasks or threads hold resources and wait for each tasks or threads to relase resources, resulting in a circular dependency and a deadlock.
 
 Deadlocks can significantly impact the performance and stability of an application.
 
 Deadlock is a situation that occurs in OS when any process enters a waiting state because another waiting process is holding the demanded resource.
 
 Deadlock is s comman problem in multi-processing where several processes share a specific type of mutually exclusive resource known as a soft lock or software.
 
 
 Deadlock  occurs when two or more threads are waiting for each other to relase a resource,resulting in a situation where none of the threads can proceed.
 
 */

final class DeadLockExample {
    
    let queue1 = DispatchQueue(label: "com.deadlock1")
    let queue2 = DispatchQueue(label: "com.deadlock2")
    let queue3 = DispatchQueue(label: "com.deadlock3")
    
   
    let lock1 = NSLock()
    let lock2 = NSLock()
    
 // Global Main Q
    
    func globalMainQ() {
        DispatchQueue.main.sync {
            print("Before DL")
        }
        
        DispatchQueue.main.sync {
            print("After DL")
        }
    }
    
    // Single Q
    
    func singleQ() {
        queue1.sync {
            print("You can print me")
        }
        
        queue1.sync {
            print("You cant print me")
        }
    }
    
    
    // Serial Queues
    
    func serialQueues() {
        
        queue2.async {  // Task 1
            
            print("Task 1 is started")
            
            self.queue3.sync { // Q2 is trying to execute a block on Q3 synchronously
                print("Task 1 is waiting for Task 2 to finish")
            }
            print("Task 1 is completed.")
        }
        
        
        queue3.async {  // Task 2
            
            print("Task 2 is started")
            
            self.queue2.sync { // Q3 is trying to execute a block on Q2 synchronously
                print("Task 2 is waiting for Task 1 to finish")
            }
            print("Task 1 is completed.")
        }
        
    }
    
    // Circular Dependancy
    
    func circularDependency() {
     
        DispatchQueue.global().async {
            print("Task 1 entered.")
            
            self.lock1.lock()
            self.lock2.lock() // Thread 1 is waiting for lock 2
            
            // do something
            
            print("Thread 1")
            
            self.lock2.unlock()
            self.lock1.unlock()
        }
        
        DispatchQueue.global().async {
            print("Task 2 entered.")
            
            self.lock2.lock()
            self.lock1.lock() // Thread 2 is waiting for lock 2
            
            // do something
            
            print("Thread 2")
            
            self.lock1.unlock()
            self.lock2.unlock()
        }
    }
    
    
    // Lock Contention / (Disagreement/Dispute)
    
    func lockContention() {
        let lock = NSLock()
        DispatchQueue.global().async {
            lock.lock()
            
            DispatchQueue.global().async { // Thread 1 is waiting for lock
                print("Here-1")
            }
            
            lock.unlock()
        }
        
        DispatchQueue.global().async {
            lock.lock()
            
            DispatchQueue.global().async { // Thread 2 is waiting for lock
                print("Here-2")
            }
            
            lock.unlock()
        }
    }
    
    
    // Resource Exhaustion
    
    func resourceExhaustion() {
        let semaphore1 = DispatchSemaphore(value: 0)
        let semaphore2 = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            print("11")
            semaphore1.wait()
            print("12")
            semaphore2.signal()
            print("13")
        }
        
        DispatchQueue.global().async {
            print("21")
            semaphore2.wait()
            print("22")
            semaphore1.signal()
            print("23")
        }
        
    }
    
}
