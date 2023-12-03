//
//  DispatchgroupLesson.swift
//  OldConcurrencyLessons
//
//  Created by Gökhan Bozkurt on 16.11.2023.
//

import Foundation

class DispatchgroupLesson {
    
    let dispatchGroup = DispatchGroup()
    
    func getUserData() {
        let queue  = DispatchQueue(label: "com.xxxxx.ios",attributes: .concurrent)
        
        dispatchGroup.enter()
        queue.async {
            sleep(1)
            print("Fetch user favaurites 1")
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        queue.async {
            sleep(2)
            print("Fetch user orders 2")
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        queue.async {
            sleep(4)
            print("Fetch user shopping card items 3 ")
            self.dispatchGroup.leave()
        }
       
        /// 1. Notify and Dont stop execution
     
        dispatchGroup.notify(queue: DispatchQueue(label: "com.User.Discounts")) {
            print("Fetching User Discounts....")
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Display landing screen.....")
        }
        
        
        
        /// 2. Stop the execution
    /*
        dispatchGroup.wait()
        DispatchQueue.main.async {
            print("I sould be the last")
        }
    */
    }
}



