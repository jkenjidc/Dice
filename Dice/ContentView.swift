//
//  ContentView.swift
//  Dice
//
//  Created by Kenji Dela Cruz on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var rotationAngle: Double = 0.0
    var body: some View {
        NavigationStack{
            VStack(spacing: 60) {
                Text(String(viewModel.rollResult))
                    .font(.system(size: 180))
                    .frame(width: viewModel.dimension, height: viewModel.dimension)
                    .foregroundStyle(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 5)
                            .rotationEffect(.degrees(rotationAngle))
                    )
                    .accessibilityLabel(viewModel.rollAnimation ? "Dice is rolling" : "Result is \(viewModel.rollResult)")
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                VStack{
                    Button {
                        withAnimation(.easeInOut(duration: 5.5)) {
                            self.rotationAngle += 1080
                            viewModel.startTimer()
                        }
                        
                    } label: {
                        Text("Roll")
                            .padding(.horizontal, 55)
                            .padding(.vertical)
                            .foregroundStyle(.white)
                            .background(viewModel.rollAnimation ? .gray : .blue)
                            .clipShape(.capsule)
                    }
                    .accessibilityLabel(viewModel.rollAnimation ? "Dice is rolling" : "Start Dice Roll")

                    .sensoryFeedback(.impact(weight: .medium, intensity: 0.9), trigger: viewModel.rollAnimation)
                    .disabled(viewModel.rollAnimation)
                    HStack{
                        Text("Dice Faces Amount")
                        Picker("Change Dice Faces Amount", selection: $viewModel.diceFaces) {
                            ForEach(0..<viewModel.facesAmount.count, id: \.self){ index in
                                Text("\(viewModel.facesAmount[index])")
                                    .onChange(of: viewModel.diceFaces) {
                                        viewModel.rollResult = 1
                                    }
                            }
                        }
                        .disabled(viewModel.rollAnimation)
                    }
                }
            }
            .navigationTitle("Dice Roll")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        RollsListView(rolls: viewModel.rolls)
                    } label: {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .resizable()
                            .frame(width: 30, height: 40)
                    }
                    .accessibilityLabel("Previous Rolls List Screen")
                }
            }
            .onReceive(viewModel.timer) { timer in
                viewModel.randomizer()
            }
            
            .onAppear {
                viewModel.stopTimer()
            }
        }
    }
}

#Preview {
    ContentView()
}
