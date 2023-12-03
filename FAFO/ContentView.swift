//
//  ContentView.swift
//  FAFO
//
//  Created by Soojeong Lee on 11/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var newTaskName = ""
    @ObservedObject var taskList = TaskList()
    @State private var showingAddTaskView = false
    @State private var selectedTask: Task?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskList.tasks) { task in
                        NavigationLink(destination: AddTaskView(newTaskName: $newTaskName, taskList: taskList, selectedTask: task)) {
                            Text(task.name)
                        }
                    }
                    .onDelete(perform: taskList.handleRemoveTask)
                }
            
                HStack {
                    Button(action: {
                        showingAddTaskView.toggle()
                        selectedTask = nil
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                    .sheet(isPresented: $showingAddTaskView) {
                        AddTaskView(newTaskName: $newTaskName, taskList: taskList, selectedTask: nil)
                    }
                }.padding()
            }
            .navigationBarTitle("Todo for Sue")
            .background(Color(UIColor.systemGray6))
        }
    }
}
