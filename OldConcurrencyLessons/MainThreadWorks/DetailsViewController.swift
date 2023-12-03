//
//  DetailsViewController.swift
//  OldConcurrencyLessons
//
//  Created by Gökhan Bozkurt on 3.12.2023.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func startOperation() {
        
        DispatchQueue.global().async { [weak self] in // Background
            sleep(2)
            guard let self = self else { return }
            DispatchQueue.main.async { // Update UI
                print("DispatchQueue.main.async")
            }
            
            // 1. Perform Selector
            self.performSelector(onMainThread: #selector(self.updateUI), with: nil, waitUntilDone: true) // true -> sync false -> async
            
            // 2. Operation Queue
            OperationQueue.main.addOperation { // Async
                print("2.OperationQueue")
            }
            
            // 3. Run Loop
            RunLoop.main.perform { // Sync
                print("3.RunLoop")
            }
        }
 
    }
    
    @objc func updateUI() {
        print("1.perform Selector")
    }
}
