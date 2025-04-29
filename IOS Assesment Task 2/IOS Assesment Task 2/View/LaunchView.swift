import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var playerName = ""
    @State private var showingSettings = false
    @State private var showingLeaderboard = false
    @State private var playingGame = false
    @State private var titleScale: CGFloat = 0.5

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("BubblePop")
                  .font(.system(size: 48, weight: .semibold, design: .rounded))
                  .scaleEffect(titleScale)
                  .onAppear {
                    withAnimation(.spring()) {
                      titleScale = 1
                    }
                  }

                Text("High Score: \(Score.shared.topScores().first?.1 ?? 0)")
                    .font(.headline)
                    .padding(.vertical, 12)
                
                TextField("What shall we call you?", text: $playerName)
                    .padding()
                    .background(Color(white: 0.9))
                    .cornerRadius(8)
                    .padding(.horizontal, 40)

                HStack(spacing: 20) {
                    Button("Start Game") {
                        gameManager.playerName = playerName.trimmingCharacters(in: .whitespaces)
                        playingGame = true
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(Capsule())
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .disabled(playerName.trimmingCharacters(in: .whitespaces).isEmpty)
                    
                    Button("Settings") {
                        showingSettings = true
                    }
                    .buttonStyle(.bordered)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .clipShape(Capsule())
                }

                Button("Leaderboard") {
                    showingLeaderboard = true
                }
                .padding(.top)
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
                .environmentObject(gameManager)
        }
        .sheet(isPresented: $showingLeaderboard) {
            ScoreboardView()
        }

        .fullScreenCover(isPresented: $playingGame) {
            GameView()
                .environmentObject(gameManager)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchView()
      .environmentObject(GameManager())
  }
}
