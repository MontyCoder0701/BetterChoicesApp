//
//  AddDesireHappenView.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation
import SwiftUI

struct AddDesireHappenView: View {
    @Binding var newDesire: String
    @Binding var newHappen: String
    @ObservedObject var desireList: DesireList
    @Environment(\.presentationMode) var presentationMode

    var selectedDesireHappen: String?

    var body: some View {
        VStack {
            Spacer()
            Text("What do I really want?")
                .font(.headline)
                .bold()
            TextEditor(text: $newDesire)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .onAppear {
                    newDesire = selectedDesireHappen?.components(separatedBy: " - ").first ?? ""
                }

            Text("Can I achive this with my impulse?")
                .font(.headline)
                .bold()
            TextEditor(text: $newHappen)
                .frame(minHeight: 100)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .onAppear {
                    newHappen = selectedDesireHappen?.components(separatedBy: " - ").last ?? ""
                }
        }
        .onDisappear {
            if let selectedDesireHappen = selectedDesireHappen {
                desireList.updateDesireHappen(selectedDesireHappen, newDesire: newDesire, newHappen: newHappen)
            } else {
                desireList.addDesireHappen(desire: newDesire, happen: newHappen)
            }
            newDesire = ""
            newHappen = ""
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
