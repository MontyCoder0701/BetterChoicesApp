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

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskList.tasks) { task in
                        Text(task.name)
                    }
                    .onDelete(perform: taskList.handleRemoveTask)
                }

                HStack {
                    TextField("New todo", text: $newTaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        taskList.handleAddTask(name: newTaskName)
                        newTaskName = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }.padding()
            }
            .navigationBarTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}
