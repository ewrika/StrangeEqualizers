//
//  RandomViewModel.swift
//  StrangeEqualizers
//
//  Created by Георгий Борисов on 15.03.2025.
//

import Foundation
import AVKit

class RandomViewModel:ObservableObject {
    weak var coordinator: Coordinator?
    @Published var volume: Int = 1
    let columns = 3

    
    @Published var randomNumbers: [Int] = Array(repeating: 1, count: 17)
    
    private var audioPlayer: AVAudioPlayer?

    
    func generateRandomNumbers() {
        randomNumbers = randomNumbers.map { _ in Int.random(in: 1...6) }
        self.audioPlayer?.volume = Float(totalSum)
    }
    
    var totalSum: Int {
        randomNumbers.reduce(0, +)
    }
    
    func setupAudioPlayer() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Ошибка настройки аудиосессии: \(error.localizedDescription)")
            }

            guard let soundURL = Bundle.main.url(forResource: "barbariki", withExtension: "mp3") else {
                print("Звуковой файл не найден")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                self.audioPlayer?.volume = Float(totalSum)
                audioPlayer?.play()
                print("Звук пошел")
            } catch {
                print("Ошибка при создании аудиоплеера: \(error.localizedDescription)")
            }
        }
    
}
