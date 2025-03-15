//
//  SolarEclipseViewModel.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import Foundation
import SwiftUI
import AVKit

class SolarEclipseViewModel: ObservableObject {
    weak var coordinator:Coordinator?
    
    @Published var offset: CGSize = .zero
    @Published var initialOffset: CGSize = .zero
    @Published var coveragePercentage: CGFloat = 0
    
    let circleSize: CGFloat = 200

    let lightBlue = Color(hex: "2eacd3")
    let darkBlue = Color(hex: "040404")
    
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        let screenHeight = UIScreen.main.bounds.height
        let initialYOffset = screenHeight / 2 - circleSize / 2 - 50 
        offset = CGSize(width: 0, height: initialYOffset)
        initialOffset = CGSize(width: 0, height: initialYOffset)
    }
    
     func backgroundColor() -> Color {
        let progress = coveragePercentage / 100
        return interpolateColor(from: lightBlue, to: darkBlue, progress: progress)
    }
    
     func interpolateColor(from startColor: Color, to endColor: Color, progress: CGFloat) -> Color {
        let startComponents = startColor.components()
        let endComponents = endColor.components()
        
        let red = startComponents.red + (endComponents.red - startComponents.red) * progress
        let green = startComponents.green + (endComponents.green - startComponents.green) * progress
        let blue = startComponents.blue + (endComponents.blue - startComponents.blue) * progress
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
    
     func calculateCoverage() {
        let radius = circleSize / 2
        let distance = sqrt(pow(offset.width, 2) + pow(offset.height, 2))
        
        if distance < 2 * radius {
            let areaOverlap = 2 * pow(radius, 2) * acos(distance / (2 * radius)) - (distance / 2) * sqrt(4 * pow(radius, 2) - pow(distance, 2))
            let circleArea = .pi * pow(radius, 2)
            coveragePercentage = (areaOverlap / circleArea) * 100
            self.audioPlayer?.volume = Float(self.coveragePercentage)

        } else {
            coveragePercentage = 0
            self.audioPlayer?.volume = Float(self.coveragePercentage)

        }
    }
    
    func setupAudioPlayer() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Ошибка настройки аудиосессии: \(error.localizedDescription)")
            }

            guard let soundURL = Bundle.main.url(forResource: "A4", withExtension: "mp3") else {
                print("Звуковой файл не найден")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.volume = Float(coveragePercentage)
                audioPlayer?.play()
                print("Звук пошел")
            } catch {
                print("Ошибка при создании аудиоплеера: \(error.localizedDescription)")
            }
        }
    
}
