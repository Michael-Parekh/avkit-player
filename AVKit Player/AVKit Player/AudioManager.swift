//
//  AudioManager.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/20/23.
//

import Foundation
import AVKit

final class AudioManager {
    // Turn this class into a singleton that will allow any views/classes/structs to access it (singleton ensures there is only one instance of the class).
    static let shared = AudioManager()
    var player: AVAudioPlayer?
    
    func startPlayer(track: String) {
        // Get the URL of the track by finding the resource in our project.
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            // If the track cannot be found, print an error and exit the function to prevent the app from crashing. 
            print("Resource not found: \(track)")
            return
        }
        
        // Since 'AVAudioPlayer' can throw an error, wrap it in a 'do-catch' block.
        do {
            // To play the audio even when the device is on silent mode, we need to add a few options to the session.
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            // At the same time, attempt to activate the session in case it fails for any reason.
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Failed to initialize player", error)
        }
    }
}
