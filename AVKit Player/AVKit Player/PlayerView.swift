//
//  PlayerView.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/18/23.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    // Prop for whether we are currently in the Xcode preview mode.
    var isPreview: Bool = false
    // Pass in the instance of 'MeditationViewModel' as a prop from 'MeditationView'.
    var meditationVM: MeditationViewModel
    // Store the current playback time as a state variable for the 'Slider'.
    @State private var value: Double = 0.0
    // SwiftUI stores the dismiss action in '@Environment' (dismiss the cover in the action closure of the dismiss button).
    @Environment(\.dismiss) var dismiss
    
    // For the timeline, we need to observe the change in time and notify the view to update itself using the timer publisher (a publisher that repeatedly emits the current time on the given interval).
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            // MARK: Background Image
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            // Use a 'Rectangle' to apply a blur view effect to the background.
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            // Overlap all of the components of the playback view on top of the background image.
            VStack(spacing: 32) {
                // MARK: Dismiss Button & Title
                // To align the dismiss button to the left, embed it in an 'HStack' and use a 'Spacer'.
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Wrap the entire playback section in a conditional statement based on whether or not there is an instance of player, so that we do not have to provide default values for everything (optional binding).
                if let player = audioManager.player {
                    // MARK: Playback Timeline
                    VStack(spacing: 5) {
                        Slider(value: $value, in: 0...player.duration)
                            .accentColor(.white)
                        
                        HStack {
                            Text("0:00")
                            // Use a spacer to push the two times apart.
                            Spacer()
                            Text("1:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                    
                    // MARK: Playback Controls
                    HStack {
                        // MARK: Repeat Button
                        PlaybackControlButton(systemName: "repeat") {
                            
                        }
                        
                        Spacer()
                        
                        // MARK: Backward Button
                        PlaybackControlButton(systemName: "gobackward.10") {
                            
                        }
                        
                        Spacer()
                        
                        // MARK: Play/Pause Button
                        PlaybackControlButton(systemName: "play.circle.fill", fontSize: 44) {
                            
                        }
                        
                        Spacer()
                        
                        // MARK: Forward Button
                        PlaybackControlButton(systemName: "goforward.10") {
                            
                        }
                        
                        Spacer()
                        
                        // MARK: Stop Button
                        PlaybackControlButton(systemName: "stop.fill") {
                            
                        }
                    }
                }
            }
            .padding(20)
        }
        .onAppear {
            // When the 'PlayerView' appears, start the audio player.
            // AudioManager.shared.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
            audioManager.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            // The view can subscribe to the timer publisher notifications with the ‘onRecieve’ modifier.
            guard let player = audioManager.player else { return }
            // Update the value of the 'Slider' with the player's current time.
            value = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    
    static var previews: some View {
        // Note that the preview became dependent on the environment object and that the preview is a separate entity from the app. For those reasons, we need to pass the environment object modifier to the preview as well (and all of the previews in the parent views).
        PlayerView(isPreview: true, meditationVM: meditationVM)
            .environmentObject(AudioManager())
    }
}
