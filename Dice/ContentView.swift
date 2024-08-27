//
//  ContentView.swift
//  Dice
//
//  Created by Kenji Dela Cruz on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                Text(String(viewModel.rollResult))
                    .font(.system(size: 200))
                    .frame(width: viewModel.dimension, height: viewModel.dimension)
                    .foregroundStyle(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 5)
                    )
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                Button {
//                    withAnimation {
//                        viewModel.rollDice()
//                    }
                    viewModel.startTimer()
                    
                } label: {
                    Text("Roll")
                        .padding(.horizontal, 55)
                        .padding(.vertical)
                        .foregroundStyle(.white)
                        .background(viewModel.disabled ? .gray : .blue)
                        .clipShape(.capsule)
                }
                .disabled(viewModel.disabled)
                HStack{
                    Text("Dice Faces Amount")
                    Picker("Dice Faces Amount", selection: $viewModel.diceFaces) {
                        ForEach(0..<viewModel.facesAmount.count, id: \.self){ index in
                            Text("\(viewModel.facesAmount[index])")
                                .onChange(of: viewModel.diceFaces) {
                                    viewModel.rollResult = 1
                                }
                        }
                    }
                    .disabled(viewModel.disabled)
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
