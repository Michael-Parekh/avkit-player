//
//  Extensions.swift
//  AVKit Player
//
//  Created by Michael Parekh on 4/19/23.
//

import Foundation

// Create an extension on 'DateComponentsFormatter' so that we can format the times of the song.
extension DateComponentsFormatter {
    // Since date formatters are expensive, utilize lazy initialization so that it won't be initialized until used (also, 'static' ensures that there is only one instance of it).
    static let abbreviated: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter.abbreviated")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }()
    
    // Method for displaying the time in 'timer form' for the 'PlayerView'.
    static let positional: DateComponentsFormatter = {
        print("Initializing DateComponentsFormatter.positional")
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter
    }()
}
