import SwiftUI

struct GameView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var showScoreboard = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Time: \(gameManager.timeRemaining)")
                            .font(.title2)
                        Spacer()
                        Text("Score: \(gameManager.score)")
                            .font(.title2)
                    }
                    .padding()

                    ZStack {
                        ForEach(gameManager.bubbles) { bubble in
                            BubbleView(bubble: bubble)
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .onAppear {
                gameManager.startGame(canvasSize: geo.size)
            }
            .onReceive(gameManager.$timeRemaining) { newTime in
                if newTime <= 0 {
                    showScoreboard = true
                }
            }
        }
        .sheet(isPresented: $showScoreboard) {
            ScoreboardView()
        }
    }
}
