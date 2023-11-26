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
                if taskList.tasks.isEmpty {
                    Spacer()
                    Text("No tasks yet. Add a new task!")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(taskList.tasks) { task in
                            Text(task.name)
                        }
                        .onDelete(perform: taskList.handleRemoveTask)
                    }
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
            .navigationBarTitle("Todo for You")
            .background(Color(UIColor.systemGray6))
        }
    }
}

#Preview {
    ContentView()
}
