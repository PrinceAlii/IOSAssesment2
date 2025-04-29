import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var playerNameInput = ""
    @State private var showingSettings = false
    @State private var navigateToGame = false
    @State private var showingLeaderboard = false
    @State private var topScore: Int = 0
    @State private var titleScale: CGFloat = 0.5

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("BubblePop")
                  .font(.system(size: 48, weight: .semibold, design: .rounded))
                  .scaleEffect(titleScale)
                  .onAppear {
                    withAnimation(.spring()) {
                      titleScale = 1
                    }
                  }
                
            
                Text("High Score: \(topScore)")
                    .font(.headline)
                    .padding(.vertical, 12)

                TextField("What shall we call you?", text: $playerNameInput)
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
                    .clipShape(Capsule())
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .disabled(playerNameInput.trimmingCharacters(in: .whitespaces).isEmpty)

                    
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
            .fullScreenCover(isPresented: $showingSettings) {
                SettingsView()
                    .environmentObject(gameManager)
            }
            .fullScreenCover(isPresented: $showingLeaderboard) {
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
