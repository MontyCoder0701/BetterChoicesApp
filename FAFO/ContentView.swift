//
//  ContentView.swift
//  FAFO
//
//  Created by Soojeong Lee on 11/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var newTaskName = ""
    @State private var newTitle = ""
    @State private var newPro = ""
    @State private var newCon = ""
    
    @ObservedObject var taskList = TaskList()
    @ObservedObject var proConList = ProConList()
    
    @State private var showingAddTaskView = false
    @State private var showingAddProConView = false
    @State private var showingFpTipsView = false
    
    @State private var selectedTask: Task?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskList.tasks) { task in
                        NavigationLink(destination: AddTaskView(newTaskName: $newTaskName, taskList: taskList, selectedTask: task)) {
                            SummaryRowView(text: task.name, date: task.date) 
                        }
                    }
                    .onDelete(perform: taskList.handleRemoveTask)
                    
                    ForEach(proConList.proCons) { proCon in
                        NavigationLink(destination: AddProConView(newTitle: $newTitle, newPro: $newPro, newCon: $newCon, proConList: proConList, selectedProCon: proCon)) {
                            SummaryRowView(text: proCon.title, date: proCon.date)
                        }
                    }
                    .onDelete(perform: proConList.handleRemoveProCon)
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
                    
                    Button(action: {
                       showingAddProConView.toggle()
                   }) {
                       Image(systemName: "list.bullet")
                   }
                   .sheet(isPresented: $showingAddProConView) {
                       AddProConView(newTitle: $newTitle,newPro: $newPro, newCon: $newCon, proConList: proConList)
                   }
                    
                    Button(action: {
                       showingFpTipsView.toggle()
                   }) {
                       Image(systemName: "heart.slash")
                   }
                   .sheet(isPresented: $showingFpTipsView) {
                       FpTipsView()
                   }
                }.padding()
            }
            .navigationBarTitle("My BPD Journal")
            .background(Color(UIColor.systemGray6))
        }
    }
}

#Preview {
    ContentView()
}
