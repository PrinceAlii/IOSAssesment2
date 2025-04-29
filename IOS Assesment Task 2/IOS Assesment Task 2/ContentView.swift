import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var gameManager: GameManager

    var body: some View {
        LaunchView()
            .environmentObject(gameManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameManager())
    }
}
    
