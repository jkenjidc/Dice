//
//  ContentView-ViewModel.swift
//  Dice
//
//  Created by Kenji Dela Cruz on 8/26/24.
//

import Foundation
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        var rolls = [DiceRoll]()
        let savePath = URL.documentsDirectory.appending(path: "SavedRolls")
        var timeLeft = 0
        var diceFaces = 6
        var facesAmount = [100, 20, 12, 10, 8, 6, 4]
        var rollResult = 1
        let dimension = CGFloat(300)
        var showList = false
        var rollAnimation = false
        var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        
        func stopTimer() {
            timer.upstream.connect().cancel()
        }
        
        func startTimer() {
//            let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
//            impactHeavy.impactOccurred()
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            timeLeft = 5
            rollAnimation =  true
        }
        
        func randomizer() {
            rollResult = Int.random(in: 1..<facesAmount[diceFaces] + 1)
            timeLeft -= 1
            if timeLeft == 0 {
                rollAnimation = false
                stopTimer()
                rollDice()
            }
        }
        func rollDice(){
            insertRoll(roll: DiceRoll(result: rollResult))
            save()
            
        }
        
        func insertRoll(roll: DiceRoll) {
            rolls.append(roll)
            save()
        }
        
        init() {
            loadData()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(rolls)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func loadData() {
            do {
                let data = try Data(contentsOf: savePath)
                rolls = try JSONDecoder().decode([DiceRoll].self, from: data)
                
            } catch {
                print("unable to fetch data")
            }
        }
    }
}
