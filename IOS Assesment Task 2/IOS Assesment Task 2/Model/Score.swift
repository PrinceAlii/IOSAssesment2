import Foundation

class Score {
    static let shared = Score()
    private var highScores: [String: Int] = [:]

    private init() {
        highScores = Persistence.loadHighScores()
    }
    
    func saveScore(name: String, score: Int) {
        let existing = highScores[name] ?? 0
        if score > existing {
            highScores[name] = score
            Persistence.saveHighScores(highScores)
        }
    }

    func topScores(limit: Int = 10) -> [(name: String, score: Int)] {
        highScores
            .sorted { $0.value > $1.value }
            .prefix(limit)
            .map { ($0.key, $0.value) }
    }
}
