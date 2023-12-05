//
//  TaskList.swift
//  FAFO
//
//  Created by Soojeong Lee on 11/26/23.
//

import Foundation

class TaskList: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        setupTasks()
    }
    
    func handleAddTask(name: String) {
        if (name.isEmpty) {
            return;
        }
        
        let task = Task(name: name, date: Date())
        tasks.append(task)
        saveTasks()
    }
    
    func handleRemoveTask(at index: IndexSet) {
        tasks.remove(atOffsets: index)
        saveTasks()
    }
    
    func handleUpdateTask(task: Task, newName: String) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }

        tasks[index].name = newName
        saveTasks()
    }
    
    private func saveTasks() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(tasks)
            UserDefaults.standard.set(data, forKey: "tasks")
        } catch {
            print("Error encoding tasks")
        }
    }
    
    private func setupTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            do {
                let decoder = JSONDecoder()
                tasks = try decoder.decode([Task].self, from: data)
            } catch {
                print("Error decoding tasks")
            }
        }
    }
}
