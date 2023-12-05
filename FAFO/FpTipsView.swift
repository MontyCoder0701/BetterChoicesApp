//
//  FpTipsView.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/5/23.
//

import Foundation
import SwiftUI

struct FpTipsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Spacer()
            
            Text("FP Tips")
                .font(.headline)
                .bold()
            
            List {
                Text("1. Do not give someone the unwanted reigns of your emotions.")
                Text("2. Stop sharing your every personal detail.")
                Text("3. Balance the amount of time you spend with each person.")
            }
            .listStyle(InsetListStyle())
            .padding(.horizontal)
            Spacer()
   
        }
        .navigationBarTitle("FP Tips")
        .onDisappear{
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
