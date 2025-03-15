//
//  PumpViewModel.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import Foundation
import SwiftUI
import AVKit

class PumpViewModel: ObservableObject {
    weak var coordinator: Coordinator?
    @Published var pressure: CGFloat = 0.1
    @Published var offset = CGSize.zero
    @Published var hasAddedPressureForCurrentStep = false
    
    private let maxHeight: CGFloat = 120
    private let minHeight: CGFloat = 0
    private let stepHeight: CGFloat = 65
    
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer? = nil
    
    func setupAudioPlayer() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Ошибка настройки аудиосессии: \(error.localizedDescription)")
            }

            guard let soundURL = Bundle.main.url(forResource: "CrazyFrog", withExtension: "mp3") else {
                print("Звуковой файл не найден")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.volume = Float(pressure)
                audioPlayer?.play()
                print("Звук пошел")
            } catch {
                print("Ошибка при создании аудиоплеера: \(error.localizedDescription)")
            }
        }
        
        func startPressureDecreaseTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                withAnimation(.easeOut(duration: 0.5)) {
                    if self.pressure > 0 {
                        self.pressure = max(self.pressure - 0.05, 0) // Уменьшаем давление на 0.01 каждую секунду
                        self.audioPlayer?.volume = Float(self.pressure)
                    }
                }
            }
        }
        
        func stopPressureDecreaseTimer() {
            timer?.invalidate()
            timer = nil
        }
        
        func updateOffset(with translation: CGSize) {
            let newHeight = offset.height + translation.height
            if newHeight >= minHeight && newHeight <= maxHeight {
                offset.height = newHeight
                
                if newHeight >= stepHeight && !hasAddedPressureForCurrentStep {
                    pressure = min(pressure + 0.1, 1.0)
                    hasAddedPressureForCurrentStep = true
                }
            }
        }
        
        func resetOffset() {
            offset.height = minHeight
            hasAddedPressureForCurrentStep = false
        }
    
}
