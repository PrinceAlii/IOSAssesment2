import SwiftUI

struct BubbleView: View {
    let bubble: Bubble
    @EnvironmentObject var gameManager: GameManager

    var body: some View {
        Circle()
            .fill(bubble.colour.color)
            .frame(width: bubble.size, height: bubble.size)
            .position(bubble.position)
            .onTapGesture {
                gameManager.pop(bubble)
            }
    }
}
