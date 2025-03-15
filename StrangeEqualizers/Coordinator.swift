//
//  Coordinator.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import Foundation
import UIKit
import SwiftUI

class Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = MainMenuViewModel()
        viewModel.coordinator = self

        let contentView = MainMenuView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: contentView)

        navigationController.pushViewController(hostingController, animated: true)
    }

    func navigateToPumpScreen() {
        let viewModel = PumpViewModel()
        viewModel.coordinator = self

        let contentView = PumpView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: contentView)

        navigationController.pushViewController(hostingController, animated: true)
    }
}
