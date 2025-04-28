import SwiftUI

// generate non overlapping bubbles
struct BubbleGenerator {
    static func generate(maxCount: Int, in canvas: CGSize) -> [Bubble] {
        var result: [Bubble] = []
        for _ in 0..<maxCount {
            let colour = randomColour()
            let size: CGFloat = 60
            let radius = size / 2
            let x = CGFloat.random(in: radius...(canvas.width - radius))
            let y = CGFloat.random(in: radius...(canvas.height - radius))
            let point = CGPoint(x: x, y: y)

            // find overlapping bubles, and skip them
            if result.contains(where: { bubble in
                let dx = bubble.position.x - point.x
                let dy = bubble.position.y - point.y
                return sqrt(dx*dx + dy*dy) < (bubble.size/2 + radius)
            }) {
                continue
            }
            result.append(Bubble(colour: colour, position: point, size: size))
        }
        return result
    }

    private static func randomColour() -> BubbleColour {
        let r = Double.random(in: 0..<1)
        if r < 0.40 { return .red }
        else if r < 0.70 { return .pink }
        else if r < 0.85 { return .green }
        else if r < 0.95 { return .blue }
        else { return .black }
    }
}
