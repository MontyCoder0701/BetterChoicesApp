//
//  ContentView.swift
//  FAFO
//
//  Created by Soojeong Lee on 11/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var newTaskName = ""
    @State private var newPro = ""
    @State private var newCon = ""
    @State private var newDesire = ""
    @State private var newHappen = ""
    
    @ObservedObject var taskList = TaskList()
    @ObservedObject var proConList = ProConList()
    @ObservedObject var desireList = DesireList()
    
    @State private var showingAddTaskView = false
    @State private var showingAddProConView = false
    @State private var showingAddDesireHappenView = false
    
    @State private var selectedTask: Task?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskList.tasks) { task in
                        NavigationLink(destination: AddTaskView(newTaskName: $newTaskName, taskList: taskList, selectedTask: task)) {
                            SummaryRowView(text: task.name)
                        }
                    }
                    .onDelete(perform: taskList.handleRemoveTask)
                    
                    ForEach(proConList.prosAndCons, id: \.self) { proCon in
                        NavigationLink(destination: AddProConView(newPro: $newPro, newCon: $newCon, proConList: proConList, selectedProCon: proCon)) {
                            SummaryRowView(text: proCon)
                        }
                    }
                    .onDelete(perform: proConList.handleRemoveProCon)
                    
                    ForEach(desireList.DesiresAndHappens, id: \.self) { desireHappen in
                        NavigationLink(destination:  AddDesireHappenView(newDesire: $newDesire, newHappen: $newHappen, desireList: desireList, selectedDesireHappen: desireHappen)) {
                            SummaryRowView(text: desireHappen)
                        }
                    }
                    .onDelete(perform: desireList.handleRemoveDesireHappen
                    )
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
                       AddProConView(newPro: $newPro, newCon: $newCon, proConList: proConList)
                   }
                    
                    Button(action: {
                       showingAddDesireHappenView.toggle()
                   }) {
                       Image(systemName: "questionmark.bubble")
                   }
                   .sheet(isPresented: $showingAddDesireHappenView) {
                       AddDesireHappenView(newDesire: $newDesire, newHappen: $newHappen, desireList: desireList)
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
