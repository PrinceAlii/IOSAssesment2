import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var gameManager: GameManager
    @Environment(\.presentationMode) private var presentationMode
    @State private var duration: Double = 60
    @State private var maxBubbles: Double = 15

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Game Settings")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Time Limit: \(Int(duration))s")
                        .font(.headline)
                    Slider(value: $duration, in: 10...120, step: 1)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Max Bubbles: \(Int(maxBubbles))")
                        .font(.headline)
                    Slider(value: $maxBubbles, in: 5...30, step: 1)
                }
                .padding(.horizontal)

                Spacer()

                HStack(spacing: 40) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.headline)
                    .frame(width: 100, height: 44)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                    Button("Save") {
                        saveSettings()
                    }
                    .font(.headline)
                    .frame(width: 100, height: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .onAppear {
                duration = Double(gameManager.settings.duration)
                maxBubbles = Double(gameManager.settings.maxBubbles)
            }
        }
    }

    private func saveSettings() {
        let newSettings = Settings(duration: Int(duration),
                                       maxBubbles: Int(maxBubbles))
        gameManager.settings = newSettings
        presentationMode.wrappedValue.dismiss()
    }
}
