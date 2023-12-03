//
//  DesireList.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation

class DesireList: ObservableObject {
    @Published var desires: [String] = []
    @Published var happens: [String] = []
    @Published var DesiresAndHappens: [String] = []

    init() {
        loadDesireList()
    }

    func addDesireHappen(desire: String, happen: String) {
        if (desire.isEmpty && happen.isEmpty) {
            return;
        }
        
        desires.append(desire)
        happens.append(happen)
        
        let combinedString = formatDesireHappenString(desire: desire, happen: happen)
        DesiresAndHappens.append(combinedString)
        
        saveDesireList()
    }
    
    func handleRemoveDesireHappen(at index: IndexSet) {
        desires.remove(atOffsets: index)
        happens.remove(atOffsets: index)
        DesiresAndHappens.remove(atOffsets: index)
        
        saveDesireList()
    }
    
    func updateDesireHappen(_ oldDesireHappen: String, newDesire: String, newHappen: String) {
        guard let index = DesiresAndHappens.firstIndex(of: oldDesireHappen) else {
            return
        }

        DesiresAndHappens.remove(at: index)
        let updatedDesireHappen = formatDesireHappenString(desire: newDesire, happen: newHappen)
        DesiresAndHappens.insert(updatedDesireHappen, at: index)
        
        saveDesireList()
    }

    private func saveDesireList() {
        let defaults = UserDefaults.standard
        defaults.set(desires, forKey: "DesiresKey")
        defaults.set(happens, forKey: "HappensKey")
        defaults.set(DesiresAndHappens, forKey: "DesiresAndHappensKey")
    }

    private func loadDesireList() {
        let defaults = UserDefaults.standard
        if let loadedDesires = defaults.stringArray(forKey: "DesiresKey") {
            desires = loadedDesires
        }

        if let loadedHappens = defaults.stringArray(forKey: "HappensKey") {
            happens = loadedHappens
        }

        if let loadedDesiresAndHappens = defaults.stringArray(forKey: "DesiresAndHappensKey") {
            DesiresAndHappens = loadedDesiresAndHappens
        }
    }
    
    private func formatDesireHappenString(desire: String, happen: String) -> String {
        return "\(desire) - \(happen)"
    }
}
