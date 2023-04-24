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
                
                // MARK: Playback Timeline
                VStack(spacing: 5) {
                    Slider(value: $value, in: 0...60)
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
            .padding(20)
        }
        .onAppear {
            // When the 'PlayerView' appears, start the audio player.
            // AudioManager.shared.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
            audioManager.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    
    static var previews: some View {
        PlayerView(isPreview: true, meditationVM: meditationVM)
    }
}
