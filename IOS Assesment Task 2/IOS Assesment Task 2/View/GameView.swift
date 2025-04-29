import SwiftUI

struct GameView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var showScoreboard = false
    @State private var sessionHigh: Int = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Time Remaining: \(gameManager.timeRemaining)")
                                .bold()
                            Text("Your High Score: \(sessionHigh)")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .bold()
                        }
                        Spacer()
                        Text("Score: \(gameManager.score)")
                            .font(.title2)
                            .bold()
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
            .navigationBarBackButtonHidden(true)
            .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
            .onAppear {
                sessionHigh = Score.shared.topScores().first { $0.0 == gameManager.playerName }?.1 ?? 0
                gameManager.startGame(canvasSize: geo.size)
            }
            .onReceive(gameManager.$score) { newScore in
                if newScore > sessionHigh {
                    sessionHigh = newScore
                }
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
