//
//  RollsListView.swift
//  Dice
//
//  Created by Kenji Dela Cruz on 8/27/24.
//

import SwiftUI

struct RollsListView: View {
    var rolls: [DiceRoll]
    var body: some View {
        NavigationStack{
            List{
                ForEach(rolls.reversed(), id: \.self) { roll in
                    HStack {
                        Text(String(roll.result))
                            .font(.system(size: 20))
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(.black, lineWidth: 1)
                            )
                        Spacer()
                        Text(roll.date)
                    }
                    .accessibilityElement()
                    .accessibilityLabel("Roll Result \(roll.result)")
                    .accessibilityHint("Made on \(roll.date)")
                    .padding(.vertical)
                }
            }
            .navigationTitle("Previous Rolls")

        }
        .padding(0)
    }
}

#Preview {
    let rolls = [DiceRoll(result: 6),DiceRoll(result: 93),DiceRoll(result: 2), DiceRoll(result: 40)]
    return RollsListView(rolls: rolls)
}
