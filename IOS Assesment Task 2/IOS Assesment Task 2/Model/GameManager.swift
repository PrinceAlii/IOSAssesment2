import SwiftUI
import Combine

// game logic and state
class GameManager: ObservableObject {
    @Published var playerName = ""
    @Published var timeRemaining: Int
    @Published var score = 0
    @Published var bubbles: [Bubble] = []
    @Published var settings: Settings

    private var timer: AnyCancellable?
    private var lastColour: BubbleColour?

    init(settings: Settings = Settings()) {
        self.settings = settings
        self.timeRemaining = settings.duration
    }

    // new game run
    func startGame(canvasSize: CGSize) {
        resetGame(canvasSize: canvasSize)
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.timeRemaining -= 1
                if self.timeRemaining > 0 {
                    self.bubbles = BubbleGenerator.generate(
                        maxCount: self.settings.maxBubbles,
                        in: canvasSize
                    )
                } else {
                    self.endGame()
                }
            }
    }
        
    // state reset for fresh fgame
    func resetGame(canvasSize: CGSize) {
        timeRemaining = settings.duration
        score = 0
        bubbles = BubbleGenerator.generate(
            maxCount: settings.maxBubbles,
            in: canvasSize
        )
        lastColour = nil
    }

    // handle a bubble pop, remove it, calculate total points, and update the score
    func pop(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index)
            let base = bubble.colour.points
            let bonus = (bubble.colour == lastColour) ? Int(Double(base) * 0.5) : 0
            score += base + bonus
            lastColour = bubble.colour
        }
    }

    private func endGame() {
        timer?.cancel()
        Score.shared.saveScore(name: playerName, score: score)
    }
}
