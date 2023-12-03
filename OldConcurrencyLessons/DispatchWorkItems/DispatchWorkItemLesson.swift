//
//  DispatchWorkItemLesson.swift
//  OldConcurrencyLessons
//
//  Created by Gökhan Bozkurt on 16.11.2023.
//

import Foundation



/*
 
 // DispatchWorkItem()
 
 1. Encapsulation
 2. Wait/Notify
 3. Priority level
 4. Cancel
 5. Modify
 
 
/// Priority levels
  .userInteractive
  .userInitiated
  .utility
  .background
 */


// 




class DispatchWorkItemLesson {
    
    let qGroup = DispatchGroup()
    
    func doSomeOperation() {
        let q1 = DispatchQueue(label: "com.yildiz.ios1")
        
        q1.async(group: qGroup) {
            sleep(2)
            print("q1 task is completed")
        }
        
        let q2 = DispatchQueue(label: "com.yildiz.ios2")
        
        q2.async(group: qGroup) {
            sleep(1)
            print("q2 task is completed")
        }
        
        let q3 = DispatchQueue(label: "com.yildiz.ios3")
        
        q3.async(group: qGroup) {
            sleep(1)
            print("q3 task is completed")
        }
        
        qGroup.notify(queue: DispatchQueue.main) {
            print("All tasks all the groups are completed")
        }
        
    }
    
    
    func encapsulationExample() {
        let workItem = DispatchWorkItem {
            sleep(3)
            print("Encapsulated async operation is done!!")
        }
        
        DispatchQueue.global().async(execute: workItem)
        
        
        // Notify and Wait
        
        /*
        workItem.notify(queue: DispatchQueue.main) {
            print("Work is Completed")
        }
        */
        
        workItem.wait()
        
        DispatchQueue.main.async {
            sleep(1)
            print("I have waited for the workitem.")
        }
        
//        DispatchQueue.global().async {
//            sleep(1)
//            print("I have waited for the workitem.")
//        }
    }
    
  
    func priorityExample() {
        
        let workItem1 = DispatchWorkItem(qos: .userInteractive) { // 1
            sleep(1)
            print("userInteractive is completed")
        }
        
        let workItem2 = DispatchWorkItem(qos: .userInitiated) { // 2
            sleep(1)
            print("userInitiated is completed")
        }
        
        let workItem3 = DispatchWorkItem(qos: .utility) { // 3
            sleep(1)
            print("utility is completed")
        }
        
        let workItemQueue = DispatchQueue(label: "com.aaa3") //Serial Queue
        
        workItemQueue.async(execute: workItem1)
        workItemQueue.async(execute: workItem2)
        workItemQueue.async(execute: workItem3)
    }
    
    func cancelExample() {
        
        let workItem = DispatchWorkItem {
            sleep(4)
            print("Work Item is completed")
        }
        
        DispatchQueue.global().async(execute: workItem)
        
        workItem.cancel()
        
        if workItem.isCancelled {
            print("Work item is cancelled")
        }
    }
    
    func modifyExample() {
        
        var  workItem = DispatchWorkItem {
            sleep(4)
            print("Work Item is completed")
        }
        
        DispatchQueue.global().async(execute: workItem)
        
        workItem.cancel()  // Cancel
        
        workItem = DispatchWorkItem { //Modify
            sleep(2)
            print("work item is cancelled,modified and completed finally.")
        }
        DispatchQueue.global().async(execute: workItem)

    }
}
