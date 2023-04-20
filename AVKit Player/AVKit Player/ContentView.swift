//
//  ContentView.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Initialize an instance of 'MeditationViewModel' with the dummy data and pass it in as a prop to 'MeditationView'.
        MeditationView(meditationVM: MeditationViewModel(meditation: Meditation.data))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
