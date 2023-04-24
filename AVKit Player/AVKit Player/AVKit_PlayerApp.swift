//
//  AVKit_PlayerApp.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/18/23.
//

import SwiftUI

@main
struct AVKit_PlayerApp: App {
    // An instance of 'AudioManager' will be created on app launch.
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            // To pass down the 'audioManager' dependency to all of its child views, add the 'EnvironmentObject' modifier to 'ContentView'.
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
