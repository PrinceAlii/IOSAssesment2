import SwiftUI
import Combine

// game logic and state
class GameManager: ObservableObject {
    @Published var playerName: String = ""
    @Published var timeRemaining: Int
    @Published var score: Int = 0
    @Published var bubbles: [Bubble] = []
    @Published var settings: Settings

    private var timerCancellable: AnyCancellable?
    private var lastPoppedColour: BubbleColour?
    private var comboCount: Int = 0

    init(settings: Settings = Settings()) {
        self.settings    = settings
        self.timeRemaining = settings.duration
    }

    // new game run
    func startGame() {
        resetGame()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.tick() }
    }

    // state reset for fresh fgame
    func resetGame() {
        timeRemaining = settings.duration
        score         = 0
        bubbles = BubbleGenerator.generate(
            maxCount: settings.maxBubbles,
            in: UIScreen.main.bounds.size
        )
        lastPoppedColour = nil
        comboCount       = 0
    }

    private func tick() {
        guard timeRemaining > 0 else {
            endGame()
            return
        }
        timeRemaining -= 1
        refreshBubbles()
    }

    // handle a bubble pop, remove it, calculate total points, and update the score
    func pop(_ bubble: Bubble) {
        guard let idx = bubbles.firstIndex(where: { $0.id == bubble.id }) else { return }
        bubbles.remove(at: idx)

        let base = bubble.colour.points
        let isCombo = bubble.colour == lastPoppedColour
        let pointsAwarded = isCombo
            ? Int(round(Double(base) * 1.5))
            : base

        score += pointsAwarded
        lastPoppedColour = bubble.colour
        comboCount       = isCombo ? comboCount + 1 : 1
    }

    // fetch bubble probabilities and create new ones based off that
    func refreshBubbles() {
        bubbles = BubbleGenerator.generate(
            maxCount: settings.maxBubbles,
            in: UIScreen.main.bounds.size
        )
    }

    private func endGame() {
        timerCancellable?.cancel()
        Score.shared.saveScore(name: playerName, score: score)
    }
}
