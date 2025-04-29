import SwiftUI

@main
struct BubblePopApp: App {
  @StateObject private var gameManager = GameManager()

  var body: some Scene {
    WindowGroup {
      LaunchView()
        .environmentObject(gameManager)
    }
  }
}
