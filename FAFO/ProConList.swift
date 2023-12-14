//
//  ProConList.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation

class ProConList: ObservableObject {
    @Published var proCons: [ProCon] = []

        init() {
            loadProConList()
        }

        func addProCon(title: String, pro: String, con: String) {
            if (title.isEmpty && pro.isEmpty && con.isEmpty) {
                return
            }

            let newProCon = ProCon(title: title, pro: pro, con: con, date:Date(), like: 0)
            proCons.append(newProCon)
            
            saveProConList()
        }
        
        func handleRemoveProCon(at index: IndexSet) {
            proCons.remove(atOffsets: index)

            saveProConList()
        }
        
        func handleLikeProCon(for proCon: ProCon) {
            guard let index = proCons.firstIndex(where: { $0.id == proCon.id }) else {
                return
            }
            
            proCons[index].like += 1
            saveProConList()
        }


        func handleUpdateProCon(_ oldProCon: ProCon, newTitle: String, newPro: String, newCon: String) {
            guard let index = proCons.firstIndex(where: { $0.id == oldProCon.id }) else {
                return
            }

            proCons[index].title = newTitle
            proCons[index].pro = newPro
            proCons[index].con = newCon
            
            saveProConList()
        }

        private func saveProConList() {
            let defaults = UserDefaults.standard
            let proConsData = try? JSONEncoder().encode(proCons)
            defaults.set(proConsData, forKey: "ProConsKey")
        }

        private func loadProConList() {
            let defaults = UserDefaults.standard
            if let proConsData = defaults.data(forKey: "ProConsKey") {
                let loadedProCons = try? JSONDecoder().decode([ProCon].self, from: proConsData)
                proCons = loadedProCons ?? []
            }
        }
}
