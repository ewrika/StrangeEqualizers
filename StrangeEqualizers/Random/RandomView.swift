//
//  RandomView.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import SwiftUI

struct RandomView: View {
    @ObservedObject var viewModel: RandomViewModel
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<(viewModel.randomNumbers.count / viewModel.columns + 1), id: \.self) { row in
                        HStack(spacing: 20) {
                            ForEach(0..<viewModel.columns, id: \.self) { column in
                                let index = row * viewModel.columns + column
                                if index < viewModel.randomNumbers.count {
                                    Image("dice\(viewModel.randomNumbers[index])")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                } else {
                                    Spacer()
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                }
                .padding()
                
                Text("You current volume: \(viewModel.totalSum)")
                
                Button(action: {
                    viewModel.generateRandomNumbers()
                }) {
                    Text("Random")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
    
        }
        .onAppear{
            viewModel.setupAudioPlayer()
        }
    }
}

#Preview {
    RandomView(viewModel: RandomViewModel())
}



