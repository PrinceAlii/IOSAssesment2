import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var playerNameInput = ""
    @State private var showingSettings = false
    @State private var navigateToGame = false
    @State private var showingLeaderboard = false
    @State private var topScore: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("BubblePop")
                    .font(.system(size: 48, weight: .bold))

                Text("High Score: \(topScore)")
                    .font(.headline)

                TextField("Enter your name", text: $playerNameInput)
                    .padding()
                    .background(Color(white: 0.9))
                    .cornerRadius(8)
                    .padding(.horizontal, 40)

                HStack(spacing: 20) {
                    Button("Start Game") {
                        gameManager.playerName = playerNameInput.trimmingCharacters(in: .whitespaces)
                        navigateToGame = true
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(playerNameInput.trimmingCharacters(in: .whitespaces).isEmpty)

                    Button("Settings") {
                        showingSettings = true
                    }
                    .buttonStyle(.bordered)
                }

                Button("Leaderboard") {
                    showingLeaderboard = true
                }
                .padding(.top)
            }
            .onAppear {
                topScore = Score.shared.topScores().first?.1 ?? 0
            }
            .background(
                NavigationLink(destination: GameView()
                                .environmentObject(gameManager),
                               isActive: $navigateToGame) {
                    EmptyView()
                }
                .hidden()
            )
            .sheet(isPresented: $showingSettings) {
                SettingsView()
                    .environmentObject(gameManager)
            }
            .sheet(isPresented: $showingLeaderboard) {
                ScoreboardView()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchView()
      .environmentObject(GameManager())
  }
}
