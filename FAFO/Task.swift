//
//  Task.swift
//  FAFO
//
//  Created by Soojeong Lee on 11/26/23.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var name: String
}
