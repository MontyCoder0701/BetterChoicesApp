//
//  AddProConView.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation
import SwiftUI

struct AddProConView: View {
    @Binding var newPro: String
    @Binding var newCon: String
    @ObservedObject var proConList: ProConList
    @Environment(\.presentationMode) var presentationMode

    var selectedProCon: String?

    var body: some View {
        VStack {
            Text("Pros")
            TextEditor(text: $newPro)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .onAppear {
                    newPro = selectedProCon?.components(separatedBy: " - ").first ?? ""
                }

            Text("Cons")
            TextEditor(text: $newCon)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .onAppear {
                    newCon = selectedProCon?.components(separatedBy: " - ").last ?? ""
                }

            Button(action: {
                if let selectedProCon = selectedProCon {
                    proConList.updateProCon(selectedProCon, newPro: newPro, newCon: newCon)
                } else {
                    proConList.addProCon(pro: newPro, con: newCon)
                }
                newPro = ""
                newCon = ""
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "plus.circle.fill")
                    .padding()
            }
        }
        .navigationBarTitle(selectedProCon != nil ? "Edit Pros and Cons" : "Add Pros and Cons")
    }
}
