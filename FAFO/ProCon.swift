//
//  ProCon.swift
//  FAFO
//
//  Created by Soojeong Lee on 12/5/23.
//

import Foundation

struct ProCon: Identifiable, Codable {
    var id = UUID()
    var title: String
    var pro: String
    var con: String
    var date: Date
    var like: Int
}
