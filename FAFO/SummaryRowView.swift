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

    var body: some View {
        HStack {
            Text(text)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
        }
    }
}
