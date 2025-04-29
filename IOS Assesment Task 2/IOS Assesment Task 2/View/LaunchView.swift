import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var playerNameInput = ""
    @State private var showingSettings = false
    @State private var navigateToGame = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("BubblePop")
                    .font(.system(size: 48, weight: .bold))

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
                .padding(.top)
            }
            .navigationTitle("Welcome")
            .sheet(isPresented: $showingSettings) {
                SettingsView()
                    .environmentObject(gameManager)
            }
            .background(
                NavigationLink(destination: GameView()
                                .environmentObject(gameManager),
                               isActive: $navigateToGame) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }
}
