//
//  ContentView.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import SwiftUI

struct MainMenuView: View {
    @ObservedObject var viewModel: MainMenuViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                MenuCard(
                    title: "Насос",
                    imagePlaceholder: "Nasos",
                    action: { viewModel.navigateToPumpScreen() }
                )
                MenuCard(
                    title: "Костер",
                    imagePlaceholder: "",
                    action: {  }
                )
                MenuCard(
                    title: "Затмение",
                    imagePlaceholder: "SunEclipse",
                    action: { viewModel.navigateToSolarEclipseScreen() }
                )
                MenuCard(
                    title: "Эквалайзер",
                    imagePlaceholder: "",
                    action: {  }
                )
            }
        }
    }
}

struct MenuCard: View {
    let title: String
    let imagePlaceholder: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 150)
                    .overlay(
                        Image(imagePlaceholder)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    )
                
                Text(title)
                    .font(.headline)
                    .padding(.top, 8)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainMenuView(viewModel: MainMenuViewModel())
}
