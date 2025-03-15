//
//  SolarEclipseView.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import SwiftUI

struct SolarEclipseView: View {
    @ObservedObject var viewModel: SolarEclipseViewModel
    
    var body: some View {
        ZStack {
            viewModel.backgroundColor()
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Circle()
                        .fill(Color(hex: "EAF08B"))
                        .frame(width: viewModel.circleSize, height: viewModel.circleSize)
                        .shadow(color: Color(hex:"EAF08B").opacity(0.8), radius: 20, x: 0, y: 0)
                    
                    Circle()
                        .fill(Color(hex:"69becc"))
                        .frame(width: viewModel.circleSize, height: viewModel.circleSize)
                        .offset(viewModel.offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    viewModel.offset = CGSize(
                                        width: viewModel.initialOffset.width + value.translation.width,
                                        height: viewModel.initialOffset.height + value.translation.height
                                    )
                                    viewModel.calculateCoverage()
                                }
                                .onEnded { value in
                                    viewModel.initialOffset = viewModel.offset
                                    viewModel.calculateCoverage()
                                }
                        )
                }
                
                Text("\(Int(viewModel.coveragePercentage))%")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                //TODO: Конфетти победы на 100%
                
                Spacer()
            }
            .padding()
        }
        .onAppear{
            viewModel.setupAudioPlayer()
        }

    }
    

}




#Preview {
    SolarEclipseView(viewModel: SolarEclipseViewModel())
}
