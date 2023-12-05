//
//  SummaryRowView.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/3/23.
//

import Foundation
import SwiftUI

struct SummaryRowView: View {
    var text: String
    var date: Date

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Text(formattedDate)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
