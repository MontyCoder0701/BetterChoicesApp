//
//  MemoView.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/7/23.
//

import Foundation
import SwiftUI

struct MemoView: View {
    @Binding var memo: Memo

    var body: some View {
        VStack {
            Spacer()
            
            Text("My Rules")
                .font(.headline)
                .bold()
                .padding()
            
            Divider().background(Color(UIColor.systemGray6))
            
            TextEditor(text: $memo.text)
                .onTapGesture {
                    hideKeyboard()
                }
        }
        .padding()
        .onDisappear {
            saveMemo()
        }
        .onAppear {
            loadMemo()
        }
    }

    private func saveMemo() {
        if let encodedMemo = try? JSONEncoder().encode(memo) {
            UserDefaults.standard.set(encodedMemo, forKey: "memo")
        }
    }

    private func loadMemo() {
        if let encodedMemo = UserDefaults.standard.data(forKey: "memo"),
           let decodedMemo = try? JSONDecoder().decode(Memo.self, from: encodedMemo) {
            memo = decodedMemo
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
