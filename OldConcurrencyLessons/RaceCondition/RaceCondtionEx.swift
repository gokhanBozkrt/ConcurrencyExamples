//
//  RaceCondtionEx.swift
//  OldConcurrencyLessons
//
//  Created by Gokhan on 13.01.2024.
//

import Foundation

final class RaceCondtion {
    var raceCounter = 0 // Mutable
    let lock = NSLock()
    func raceCondition1() {
        DispatchQueue.concurrentPerform(iterations: 100) { index in
            lock.lock()
            raceCounter += 1
            lock.unlock()
        }
        print(raceCounter)
        print(raceCounter)
        print(raceCounter)
        
        self.raceCounter = 0
    }
    
    func raceCondition2() {
        DispatchQueue.global().async {
            self.raceCounter += 1
        }
        DispatchQueue.global().async {
            self.raceCounter += 1
        }
        DispatchQueue.global().async {
            self.raceCounter += 1
        }
        print(raceCounter)
        self.raceCounter = 0
    }
}


