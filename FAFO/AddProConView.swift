//
//  AddProConView.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation
import SwiftUI

struct AddProConView: View {
    @Binding var newTitle: String
    @Binding var newPro: String
    @Binding var newCon: String
    
    @ObservedObject var proConList: ProConList
    @Environment(\.presentationMode) var presentationMode

    var selectedProCon: ProCon?

    var body: some View {
        VStack {
            Spacer()
            Text("Impulse")
                .font(.headline)
                .bold()
            TextEditor(text: $newTitle)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
            
            Text("Pros")
                .font(.headline)
                .bold()
            TextEditor(text: $newPro)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)

            Text("Cons")
                .font(.headline)
                .bold()
            TextEditor(text: $newCon)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
        }
        .onAppear {
            if let selectedProCon = selectedProCon {
                newTitle = selectedProCon.title
                newPro = selectedProCon.pro
                newCon = selectedProCon.con
            }
        }
        .onDisappear {
            if let selectedProCon = selectedProCon {
                proConList.handleUpdateProCon(selectedProCon, newTitle: newTitle, newPro: newPro, newCon: newCon)
            } else {
                proConList.addProCon(title: newTitle, pro: newPro, con: newCon)
            }
            
            newTitle = ""
            newPro = ""
            newCon = ""
            presentationMode.wrappedValue.dismiss()
        }
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 50 {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .navigationBarHidden(true)
    }
}
