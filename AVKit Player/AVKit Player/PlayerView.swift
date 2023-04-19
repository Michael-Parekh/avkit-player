//
//  PlayerView.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/18/23.
//

import SwiftUI

struct PlayerView: View {
    // Store the current playback time as a state variable for the 'Slider'.
    @State private var value: Double = 0.0
    
    var body: some View {
        ZStack {
            // MARK: Background Image
            Image("image-feather")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            // Overlap all of the components of the playback view on top of the background image.
            VStack(spacing: 32) {
                // MARK: Dismiss Button & Title
                // To align the dismiss button to the left, embed it in an 'HStack' and use a 'Spacer'.
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                Text("1 Minute Relaxing Meditation")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                // MARK: Playback Controls
                VStack(spacing: 5) {
                    // Utilize a 'Slider' to represent the playback timeline.
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
            }
            .padding(20)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
