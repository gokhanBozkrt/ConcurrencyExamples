//
//  OperationUsage.swift
//  OldConcurrencyLessons
//
//  Created by Gökhan Bozkurt on 20.11.2023.
//

import Foundation


/*
 Operations Vs GCD
 
 1.Dependancy -> Use Operations
 2.Cancellation -> Both
 3.Priorities -> Both
 4.Concurrency/Number of conccurent Tasks -> Operations
 5.Size of the task -> Operation
 
 */

/* 1. Dependancy */

// Operations

class DownloadOperation: Operation {
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func main() {
        if isAsynchronous {
            print("Download is successfull")
        }
    }
    
   
}

class ProcessOperation: Operation {
    override func main() {
        print("Processing is successfull")
    }
}

class ImageDownloadHandler {
    let imageQueue = OperationQueue()
    
    let downloadoperation = DownloadOperation()
    let processOperation = ProcessOperation()
    
    func downloadImagesWithOperation() {
        processOperation.addDependency(downloadoperation)
        if downloadoperation.isAsynchronous {
            print("down")
        }
        imageQueue.addOperation(downloadoperation)
        imageQueue.addOperation(processOperation)
  
        
    }
    
}

// GCD

class DownloadImageWithGCD {

    let downloadQueue = DispatchQueue.global(qos: .background)
    let processQueue = DispatchQueue.main
    
    func downloadImages() {
        downloadQueue.async {
            let url = URL(string: "")
            let imageData = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                // Assign to ImageView
            }
        }
    }
    
}

/* 2. Cancellation */


// Operations

class LongRunningOperation: Operation {
    override func main() {
        guard !isCancelled else { return }
        
        // Long Running task here..
        print("In the middle of long runnig task")
        
        sleep(3)
        
        if isCancelled {
            print("Long runnig task has been cancelled")
            return
        }
        sleep(2)
        // Complete task...
        print("Long runnig task is completed!")
    }
}

class OperationCancelExample {
    let longRunnigQueue = OperationQueue()
    let longRunnigOperation = LongRunningOperation()
    
    func operationCancellation() {
        longRunnigQueue.addOperation(longRunnigOperation)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.longRunnigOperation.cancel()
        }
    }
}

// GCD

class LongRunningTaskWithCGD {
    
    func longRunnigTaskWithCGD() {
        let workItem = DispatchWorkItem {
            print("In the middle of long runnig task GCD")
            sleep(3)
            
            
         /// It does not work inside it
//            if workItem.isCancelled {
//                print("Long runnig task has been cancelled GCF")
//                
//            }
            
            // Complete task...
            print("Long runnig task is completed! GCD")
        }
       
        
        DispatchQueue.global().async(execute: workItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            workItem.cancel()
           
        }
    }
}


/*3. Priorioties */

// Operations

class PrioritiesOperation {
    
    func operationPriorites() {
        let priorityQueu = OperationQueue()
        
        let highPriorityOperation = Operation()
        highPriorityOperation.qualityOfService = .userInteractive
        
        let middlePriorityOperation = Operation()
        middlePriorityOperation.qualityOfService = .userInitiated
        
        let lowPriorityOperation = Operation()
        lowPriorityOperation.qualityOfService = .utility
        
       
        
        priorityQueu.addOperations([highPriorityOperation,middlePriorityOperation,lowPriorityOperation], waitUntilFinished: true)
    }
    
}


//GCD

class PrioritiesWithGCD {
    let highPriorityQueue = DispatchQueue.global(qos: .userInteractive)
    let midllePriorityQueue = DispatchQueue.global(qos: .userInitiated)
    let lowriorityQueue = DispatchQueue.global(qos: .utility)
    
    func priorityWithGCD() {
        highPriorityQueue.async {
            
        }
        midllePriorityQueue.async {
            
        }
        lowriorityQueue.async {
            
        }
    }
}



/* 4.Concurrency/Number of concurrent tasks */

//Operations

class ImagesDownloadOperation: Operation {
    init(url: URL) {
        
    }
    override func main() {
        
    }
}

class ImagesDownloadOperationExample {
    let concurrentOperation = OperationQueue()
    let imageUrls = [URL]()
    func imagesDownloadOperationExample() {
        concurrentOperation.maxConcurrentOperationCount = 2
        
        for url in imageUrls {
            let operation = ImagesDownloadOperation(url: url)
            concurrentOperation.addOperation(operation)
        }
    }
}


//GCD

class ImagesDownloadGCD {
    let queue = DispatchQueue(label: "com.xxxxx",attributes: .concurrent)
    let imageUrls = [URL]()
  

    func startDownloading() {
        for _ in imageUrls {
            queue.async {
                // Download Image from URL
            }
        }
    }
    
}


/* 5.Size of the task */

//Operation

class FileDownloadOperation: Operation {
    let url: URL
    var downloadedData: Data?
    
    init(url: URL) {
        self.url = url
    }
    
    override func main() {
        if isCancelled { return }
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url) { data,response,error in
            self.downloadedData = data
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}


class FileDownloadGCD {
    func dıwnloadFile() {
        DispatchQueue.global().async {
            // Resize Image
        }
        DispatchQueue.main.async {
            // Show in the view
        }
    }
}



