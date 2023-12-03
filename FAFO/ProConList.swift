//
//  ProConList.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation

class ProConList: ObservableObject {
    @Published var pros: [String] = []
    @Published var cons: [String] = []
    @Published var prosAndCons: [String] = []

    init() {
        loadProConList()
    }

    func addProCon(pro: String, con: String) {
        if (pro.isEmpty && con.isEmpty) {
            return;
        }
        
        pros.append(pro)
        cons.append(con)
        
        let combinedString = formatProConString(pro: pro, con: con)
        prosAndCons.append(combinedString)
        
        saveProConList()
    }
    
    func handleRemoveProCon(at index: IndexSet) {
        pros.remove(atOffsets: index)
        cons.remove(atOffsets: index)
        prosAndCons.remove(atOffsets: index)
        
        saveProConList()
    }
    
    func updateProCon(_ oldProCon: String, newPro: String, newCon: String) {
        guard let index = prosAndCons.firstIndex(of: oldProCon) else {
            return
        }

        prosAndCons.remove(at: index)
        let updatedProCon = formatProConString(pro: newPro, con: newCon)
        prosAndCons.insert(updatedProCon, at: index)
        
        saveProConList()
    }

    private func saveProConList() {
        let defaults = UserDefaults.standard
        defaults.set(pros, forKey: "ProsKey")
        defaults.set(cons, forKey: "ConsKey")
        defaults.set(prosAndCons, forKey: "ProsAndConsKey")
    }

    private func loadProConList() {
        let defaults = UserDefaults.standard
        if let loadedPros = defaults.stringArray(forKey: "ProsKey") {
            pros = loadedPros
        }

        if let loadedCons = defaults.stringArray(forKey: "ConsKey") {
            cons = loadedCons
        }

        if let loadedProsAndCons = defaults.stringArray(forKey: "ProsAndConsKey") {
            prosAndCons = loadedProsAndCons
        }
    }
    
    private func formatProConString(pro: String, con: String) -> String {
        return "\(pro) - \(con)"
    }
}
