import Foundation

// save highscores to a JSON file for now
struct Persistence {
    static private var highScoresURL: URL {
        let documents = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask
        ).first!
        return documents.appendingPathComponent("highScores.json")
    }

    // attempt to find highscores in JSON file, return empty if not found
    static func loadHighScores() -> [String: Int] {
        let url = highScoresURL
        guard let data = try? Data(contentsOf: url) else {
            return [:]
        }
        return (try? JSONDecoder().decode([String: Int].self, from: data)) ?? [:]
    }

    // save auotmatically
    static func saveHighScores(_ scores: [String: Int]) {
        guard let data = try? JSONEncoder().encode(scores) else {
            return
        }
        try? data.write(to: highScoresURL, options: [.atomicWrite])
    }
}
