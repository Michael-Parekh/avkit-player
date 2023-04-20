//
//  MeditationView.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/18/23.
//

import SwiftUI

struct MeditationView: View {
    // This view becomes a subscriber to the 'MeditationViewModel'.
    @StateObject var meditationVM: MeditationViewModel
    @State private var showPlayer = false
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Image
            // The asset image should take up 1/3 of the height of the device's screen.
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
            
            // MARK: Song Details
            // The song details should take up the other 2/3 of the height of the device's screen.
            ZStack {
                Color(red: 24/255, green: 23/255, blue: 22/255)
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Music")
                        Text(meditationVM.meditation.duration.formatted() + "S")
                    }
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)
                    
                    Text(meditationVM.meditation.title)
                        .font(.title)
                    
                    Button {
                        showPlayer = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            // Ensure that the button takes up the 'maxWidth' of the parent container.
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(20)
                    }

                    Text(meditationVM.meditation.description)
                    
                    // Use a 'Spacer' to push the text to the top of the 'VStack'.
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(20)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 3)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPlayer) {
            // Bind the two screens together by showing the ‘PlayerView’ as a 'fullScreenCover' when the play button is tapped (the 'showPlayer' state is set to true).
            PlayerView()
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    // Initialize 'MeditationViewModel' with the dummy data and store it in a static variable.
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    
    static var previews: some View {
        MeditationView(meditationVM: meditationVM)
    }
}
