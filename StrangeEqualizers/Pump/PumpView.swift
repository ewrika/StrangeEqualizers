//
//  PumpView.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import SwiftUI
import AVKit

struct PumpView: View {
    @ObservedObject var viewModel: PumpViewModel
    
    var body: some View {
        HStack() {
            VStack {
                VStack{
                    Rectangle()
                        .frame(width: 100, height: 10)
                        .foregroundColor(.gray)
                        .offset(y:-60)
                    
                    Rectangle()
                        .frame(width: 150, height: 10)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(90))
                }
                
                .offset(x: 0, y: viewModel.offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            withAnimation(.easeOut(duration: 0.5)) {
                                viewModel.updateOffset(with: gesture.translation)
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                viewModel.resetOffset()
                            }
                        }
                )
                
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 60, height: 180)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    VStack {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 40, height: 150 * viewModel.pressure)
                    }
                }
            }
        }
        .onAppear{
            viewModel.setupAudioPlayer()
            viewModel.startPressureDecreaseTimer()
        }
        .onDisappear{
            viewModel.stopPressureDecreaseTimer()
        }
    }
}

#Preview {
    PumpView(viewModel: PumpViewModel())
}
