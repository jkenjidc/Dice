//
//  DiceRoll.swift
//  Dice
//
//  Created by Kenji Dela Cruz on 8/26/24.
//

import Foundation

struct DiceRoll: Codable, Identifiable, Hashable {
    var id = UUID()
    let result: Int
    let date: String
    
    init(result: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        self.result = result
        self.date = formatter.string(from: Date())
    }
}
