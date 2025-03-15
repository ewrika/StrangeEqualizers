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
   
    func navigateToSolarEclipseScreen() {
        coordinator?.navigateToSolarEclipseScreen()
    }
    
    
    func navigateToRandomScreen() {
        coordinator?.navigateToRandomScreen()
    }
    
    /*
    func navigateToEqualizerScreen() {
        coordinator?.navigateToEqualizerScreen()
    }
    */
    
}
