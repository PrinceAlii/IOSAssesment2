import SwiftUI

struct BubbleGenerator {
    static func generate(maxCount: Int, in canvas: CGSize) -> [Bubble] {
        var result: [Bubble] = []
        let diameter: CGFloat = 60
        let radius = diameter / 2

        // define valid centre range
        let minX = radius
        let maxX = canvas.width - radius
        let minY = radius
        let maxY = canvas.height - radius

        for _ in 0..<maxCount {
            let colour = randomColour()
            
            // choose a random point thats fully inside bounds
            let x = CGFloat.random(in: minX...maxX)
            let y = CGFloat.random(in: minY...maxY)
            let bubble = Bubble(colour: colour,
                                position: CGPoint(x: x, y: y),
                                size: diameter)

            // skip if the bubbles are going to overlap
            if result.contains(where: { existing in
                let dx = existing.position.x - x
                let dy = existing.position.y - y
                return sqrt(dx*dx + dy*dy) < (existing.size/2 + radius)
            }) {
                continue
            }

            result.append(bubble)
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
