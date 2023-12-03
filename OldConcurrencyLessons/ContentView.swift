//
//  ContentView.swift
//  OldConcurrencyLessons
//
//  Created by Gökhan Bozkurt on 16.11.2023.
//

import SwiftUI



struct ContentView: View {
    
    var group = DispatchgroupLesson()
    var workItem = DispatchWorkItemLesson()
    var syncAndAsync = DoTasksAsyncAndSync()
    var operations = Operations()
    var imageDownloadWithOperation = ImageDownloadHandler()
    var operationCancellation = OperationCancelExample()
    var gcdCancellation = LongRunningTaskWithCGD()
    var mainThreadOp = DetailsViewController()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onTapGesture {
            mainThreadOp.startOperation()
        }
    }
}

#Preview {
    ContentView()
}
