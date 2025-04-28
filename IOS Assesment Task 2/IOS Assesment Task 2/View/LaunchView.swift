import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var playerNameInput: String = ""
    @State private var showingSettings: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("BubblePop 9000")
                    .font(.system(size: 44, weight: .bold))

                TextField("Name", text: $playerNameInput)
                    .padding()
                    .background(Color(white: 0.9))
                    .cornerRadius(8)
                    .padding(.horizontal, 40)

                HStack(spacing: 20) {
                    Button(action: startGame) {
                        Text("Start Game")
                            .frame(minWidth: 100)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(playerNameInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                    Button(action: { showingSettings = true }) {
                        Text("Settings")
                            .frame(minWidth: 100)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Welcome")
            .sheet(isPresented: $showingSettings) {
                SettingsView()
                    .environmentObject(gameManager)
            }
        }
    }

    private func startGame() {
        gameManager.playerName = playerNameInput.trimmingCharacters(in: .whitespacesAndNewlines)
        gameManager.startGame()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(GameManager())
    }
}

