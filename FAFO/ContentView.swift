//
//  ContentView.swift
//  FAFO
//
//  Created by Soojeong Lee on 11/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var newTitle = ""
    @State private var newPro = ""
    @State private var newCon = ""
    @ObservedObject var proConList = ProConList()
    @State private var showingAddProConView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(proConList.proCons) { proCon in
                        NavigationLink(destination: AddProConView(newTitle: $newTitle, newPro: $newPro, newCon: $newCon, proConList: proConList, selectedProCon: proCon)) {
                            SummaryRowView(text: proCon.title, date: proCon.date)
                        }
                    }
                    .onDelete(perform: proConList.handleRemoveProCon)
                }
            
            
                HStack {
                    Button(action: {
                       showingAddProConView.toggle()
                   }) {
                       Image(systemName: "square.and.pencil")
                   }
                   .sheet(isPresented: $showingAddProConView) {
                       AddProConView(newTitle: $newTitle,newPro: $newPro, newCon: $newCon, proConList: proConList)
                   }
                }
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Better Choices")
        }
    }
}

#Preview {
    ContentView()
}
