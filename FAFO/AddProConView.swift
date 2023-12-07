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
        ScrollView {
            VStack {
                Spacer()
                
                Text("Impulse")
                    .font(.headline)
                    .bold()
                    .padding()
                
                Divider().background(Color(UIColor.systemGray6))
                
                TextEditor(text: $newTitle)
                    .frame(minHeight: 75)
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                Text("Pros")
                    .font(.headline)
                    .bold()
                    .padding()
                
                Divider().background(Color(UIColor.systemGray6))
                
                TextEditor(text: $newPro)
                    .frame(minHeight: 150)
                    .onTapGesture {
                        hideKeyboard()
                    }

                Text("Cons")
                    .font(.headline)
                    .bold()
                    .padding()
                
                Divider().background(Color(UIColor.systemGray6))
                
                TextEditor(text: $newCon)
                    .frame(minHeight: 150)
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
            .padding()
            .frame(maxWidth: .infinity)
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
            .onTapGesture {
                hideKeyboard()
            }
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
