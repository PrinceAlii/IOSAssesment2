import SwiftUI

enum BubbleColour: CaseIterable {
    case green, blue, black, red, pink

    // declaring the points value for each bubble, the probability of each bubble spwaning, and the colour of each bubble
    
    var points: Int {
        switch self {
        case .green: return 5
        case .blue:  return 8
        case .black: return 10
        case .red:   return 1
        case .pink:  return 2
        }
    }

    var probability: Double {
        switch self {
        case .green: return 0.15
        case .blue:  return 0.10
        case .black: return 0.05
        case .red:   return 0.40
        case .pink:  return 0.30
        }
    }

    var color: Color {
        switch self {
        case .green: return .green
        case .blue:  return .blue
        case .black: return .black
        case .red:   return .red
        case .pink:  return .pink
        }
    }
}

// bubble on the screen
struct Bubble: Identifiable {
    let id: UUID = UUID()
    let colour: BubbleColour
    var position: CGPoint
    let size: CGFloat
}

