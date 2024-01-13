//
//  AtomicCounter.swift
//  OldConcurrencyLessons
//
//  Created by Gokhan on 13.01.2024.
//

import Foundation

final class AtomicCounter {
    private var counter = 0
    private let lock = NSLock()
    
  private  func add(val: Int) {
        lock.lock()
        counter += val
        lock.unlock()
    }
    
  private  func subtract(val: Int) {
        lock.lock()
        counter -= val
        lock.unlock()
    }
    
   private func doTasks() {
        DispatchQueue.concurrentPerform(iterations: 100) { index in
            add(val: 1)
        }
       DispatchQueue.concurrentPerform(iterations: 50) { index in
           subtract(val: 1)
       }
    }
    
    func getCounter() {
        doTasks()
        lock.lock()
        print(counter)
        lock.unlock()
        self.counter = 0
    }
}
