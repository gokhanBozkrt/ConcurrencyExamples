//
//  Global_Custom_Queues.swift
//  OldConcurrencyLessons
//
//  Created by Gokhan on 30.12.2023.
//

/*
 
 Global DispatchQueues
 
 1. System Provided
 2. Categorized based on the QoS
 3. Concurrent
 
 For simple UI updates and I/O operations 
 vs
 
 Custom DispatchQueues
 
 1. Developer defines
 2. Identified based on the label
 3. Serial / Concurrent
 
 For Complex data processing,Thread-Safety,
 
 */



import Foundation


class QueueTypes {
  
    
    func globalQueues() {
        
        DispatchQueue.main.async { // Serial
            // For UI
        }
        
        DispatchQueue.global(qos: .utility).async {
            
        }
        
        DispatchQueue.global(qos: .utility).async {
            
        }
        
    }
    
    
    func customQueue() {
        let customQueue = DispatchQueue(label: "com.file",qos: .userInitiated,
                                        attributes: .concurrent) // Serial, Concurrent
        let customQueue2 = DispatchQueue(label: "com.image",qos: .userInitiated)
        
    }
    
    
}
