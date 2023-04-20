//
//  MeditationViewModel.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/19/23.
//

import Foundation

// A view model is used to hold presentation logic and acts as a messenger between the view <=> model.
// Conforms to the 'ObservableObject' protocol to turn it into a publisher (any view that subscribes to it will get updated).
final class MeditationViewModel: ObservableObject {
    // Ensures that 'Meditation' can only be updated in this class.
    private(set) var meditation: Meditation
    
    init(meditation: Meditation) {
        self.meditation = meditation
    }
}

// A model is used to pass data around the application efficiently (not necessary for this example app where we only have one song in the colleciton).
struct Meditation {
    let id = UUID()
    let title: String
    let description: String
    let duration: TimeInterval
    let track: String
    let image: String
    
    // Instantiate the 'Meditation' dummy data once and store it as a static variable ('static' allows the property to be shared among all instances of the 'struct').
    static let data = Meditation(title: "1 Minute Relaxing Meditation", description: "Clear your mind and slumber into nothingness. Allocate only a few moments for a quick breather.", duration: 70, track: "meditation1", image: "image-feather")
}
