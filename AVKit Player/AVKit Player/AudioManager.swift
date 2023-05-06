//
//  AudioManager.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/20/23.
//

import Foundation
import AVKit

// Conforms to the 'ObservableObject' protocol to turn it into a publisher (any view that subscribes to it will get updated).
final class AudioManager: ObservableObject {
    // Singleton is an anti-pattern because only parts of the app that need the ‘AudioManager’ should have access to it. Since we still want to keep ‘AudioManager’ as a single instance, we have to initialize it early in the app (in 'AVKit_PlayerApp', for example).
    // static let shared = AudioManager()
    
    @Published var player: AVAudioPlayer?
    @Published private(set) var isPlaying: Bool = false {
        didSet {
            // Use the 'didSet' observer to print when it has a new value (state is updated accordingly whenever we click play/pause).
            print("isPlaying", isPlaying)
        }
    }
    
    func startPlayer(track: String, isPreview: Bool = false) {
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
            
            if isPreview {
                // Instead of playing the track right away, we will 'prepareToPlay' if in the Xcode preview (fix the nonstop music in the 'PlayerView' preview).
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true
            }
        } catch {
            print("Failed to initialize player", error)
        }
    }
    
    func playPause() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        
        // If the player is playing currently, let it pause. But if the player is paused currently, then let it play.
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
}
