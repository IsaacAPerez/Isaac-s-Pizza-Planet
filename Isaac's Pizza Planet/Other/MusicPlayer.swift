//
//  MusicPlayer.swift
//  Isaac's Pizza Planet
//
//  Created by Isaac Abel Perez on 4/28/20.
//  Copyright © 2020 Isaac Abel Perez. All rights reserved.
//

import Foundation
import AVFoundation

// This Class creates a MusicPlayer that plays "The Office" Theme Song
class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    var bitPlayer: AVAudioPlayer?
    var tapPlayer: AVAudioPlayer?
    var gamePlayer: AVAudioPlayer?
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "song", ofType: "m4a") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                print("played")
            } catch {
                print(error)
            }
        }
    }
    func bitSound() {
        if let bundle = Bundle.main.path(forResource: "bit", ofType: "m4a") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                bitPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let bitPlayer = bitPlayer else { return }
                bitPlayer.numberOfLoops = 0
                bitPlayer.prepareToPlay()
                bitPlayer.play()
                print("played")
            } catch {
                print(error)
            }
        }
    }
    func tapSound() {
        if let bundle = Bundle.main.path(forResource: "Tiny", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                tapPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let tapPlayer = tapPlayer else { return }
                tapPlayer.numberOfLoops = 0
                tapPlayer.prepareToPlay()
                tapPlayer.play()
                print("played")
            } catch {
                print(error)
            }
        }
    }
    func gameSound() {
        if let bundle = Bundle.main.path(forResource: "game", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                gamePlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let gamePlayer = gamePlayer else { return }
                gamePlayer.numberOfLoops = -1
                gamePlayer.prepareToPlay()
                gamePlayer.play()
                print("played")
            } catch {
                print(error)
            }
        }
    }
    func stop() {
        audioPlayer?.stop()
    }
    func stopGame() {
        gamePlayer?.stop()
    }
}
