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
            Spacer()
            Text("Pros")
                .font(.headline)
                .bold()
            TextEditor(text: $newPro)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .onAppear {
                    newPro = selectedProCon?.components(separatedBy: " - ").first ?? ""
                }

            Text("Cons")
                .font(.headline)
                .bold()
            TextEditor(text: $newCon)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .onAppear {
                    newCon = selectedProCon?.components(separatedBy: " - ").last ?? ""
                }
        }
        .onDisappear {
            if let selectedProCon = selectedProCon {
                proConList.handleUpdateProCon(selectedProCon, newPro: newPro, newCon: newCon)
            } else {
                proConList.addProCon(pro: newPro, con: newCon)
            }
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
