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
            Spacer()
            
            Text("Journal")
                .font(.headline)
                .bold()
                .padding()
            
            Divider().background(Color(UIColor.systemGray6))
            
            TextEditor(text: $newTaskName)
                .frame(minHeight: 100)
                .onTapGesture {
                    hideKeyboard()
                }
                .onAppear {
                    newTaskName = selectedTask?.name ?? ""
                }
        }
        .padding()
        .navigationBarTitle(selectedTask != nil ? "Edit Entry" : "")
        .onDisappear{
            if let task = selectedTask {
                taskList.handleUpdateTask(task: task, newName: newTaskName)
            } else {
                taskList.handleAddTask(name: newTaskName)
            }
            newTaskName = ""
            presentationMode.wrappedValue.dismiss()
        }
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 50 {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .navigationBarHidden(true)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
