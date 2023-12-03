//
//  AddTaskView.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation
import SwiftUI

struct AddTaskView: View {
    @Binding var newTaskName: String
    @ObservedObject var taskList: TaskList
    @Environment(\.presentationMode) var presentationMode
    var selectedTask: Task?

    var body: some View {
        VStack {
            TextEditor(text: $newTaskName)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .onAppear {
                    newTaskName = selectedTask?.name ?? ""
                }

            Button(action: {
                if let task = selectedTask {
                    taskList.updateTask(task: task, newName: newTaskName)
                } else {
                    taskList.handleAddTask(name: newTaskName)
                }
                newTaskName = ""
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "plus.circle.fill")
                    .padding()
            }
        }
        .navigationBarTitle(selectedTask != nil ? "Edit Memo" : "Add Memo")
    }
}
