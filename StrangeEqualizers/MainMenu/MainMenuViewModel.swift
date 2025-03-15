//
//  MainMenuViewModel.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import Foundation

class MainMenuViewModel: ObservableObject {
    weak var coordinator: Coordinator?

    func navigateToPumpScreen() {
        coordinator?.navigateToPumpScreen()
    }
    /*
    func navigateToBonfireScreen() {
        coordinator?.navigateToBonfireScreen()
    }

    func navigateToEclipseScreen() {
        coordinator?.navigateToEclipseScreen()
    }

    func navigateToEqualizerScreen() {
        coordinator?.navigateToEqualizerScreen()
    }
    */
}
