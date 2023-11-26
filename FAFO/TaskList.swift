//
//  TaskList.swift
//  FAFO
//
//  Created by Soojeong Lee on 11/26/23.
//

import Foundation

class TaskList: ObservableObject {
    @Published var tasks: [Task] = []
    
    func handleAddTask(name: String) {
        let task = Task(name: name)
        tasks.append(task)
    }
    
    func handleRemoveTask(at index: IndexSet) {
        tasks.remove(atOffsets: index)
    }
}
