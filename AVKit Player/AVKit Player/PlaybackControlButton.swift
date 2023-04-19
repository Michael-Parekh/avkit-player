//
//  PlaybackControlButton.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/19/23.
//

import SwiftUI

// Create a reusable button component with default values since we have alot of playback controls (the only required property is the 'action' function).
struct PlaybackControlButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 24
    var color: Color = .white
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }

    }
}

struct PlaybackControlButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackControlButton(action: {})
            .preferredColorScheme(.dark)
    }
}
