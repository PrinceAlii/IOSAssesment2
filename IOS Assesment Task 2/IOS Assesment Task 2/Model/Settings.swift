// mainly for debug, hardcode later?

struct Settings {
    private(set) var duration: Int {
        didSet {
            duration = min(max(duration, 1), 100)
        }
    }

    private(set) var maxBubbles: Int {
        didSet {
            maxBubbles = min(max(maxBubbles, 1), 100)
        }
    }

    init(duration: Int = 60, maxBubbles: Int = 15) {
        self.duration   = min(max(duration, 1), 100)
        self.maxBubbles = min(max(maxBubbles, 1), 100)
    }
}
