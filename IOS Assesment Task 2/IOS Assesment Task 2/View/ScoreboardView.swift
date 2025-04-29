import SwiftUI

struct ScoreboardView: View {
    let scores = Score.shared.topScores()

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(scores.enumerated()), id: \.offset) { index, element in
                    HStack {
                        Text("\(index + 1). ")
                            .bold()
                        Text(element.0)
                        Spacer()
                        Text("\(element.1)")
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("High Scores")
        }
    }
}
