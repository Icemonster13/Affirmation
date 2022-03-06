//
//  PlaySounds.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/26/22.
//

import AVFoundation
import SwiftUI

// MARK: - PROPRERTIES
var audioPlayer: AVAudioPlayer?

// MARK: - FUNCTIONS
func playSound(sound: String, type: String, enabled: Bool) {
    if !enabled {
        // print("Sound is disabled")
    } else {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Error: Could not find and play the sound file!")
            }
        }
    }
}
