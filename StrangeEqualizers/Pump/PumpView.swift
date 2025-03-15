//
//  PumpView.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import SwiftUI

struct PumpView: View {
    @ObservedObject var viewModel: PumpViewModel
    
    var body: some View {
        Text("Pump")
    }
}

#Preview {
    PumpView(viewModel: PumpViewModel())
}
