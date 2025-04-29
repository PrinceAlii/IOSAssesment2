import SwiftUI

struct BubbleView: View {
    let bubble: Bubble
    @EnvironmentObject private var gameManager: GameManager

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [bubble.colour.color.opacity(0.8), bubble.colour.color]),
                        center: .center,
                        startRadius: bubble.size * 0.1,
                        endRadius: bubble.size
                    )
                )
                .frame(width: bubble.size, height: bubble.size)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)

            Circle()
                .fill(Color.white.opacity(0.4))
                .frame(width: bubble.size * 0.3, height: bubble.size * 0.3)
                .offset(x: -bubble.size * 0.2, y: -bubble.size * 0.2)
        }
        .position(bubble.position)
        .onTapGesture {
            gameManager.pop(bubble)
        }
    }
}
