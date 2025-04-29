import SwiftUI

struct ScoreboardView: View {
    @Environment(\.presentationMode) private var presentationMode
    private let scores = Score.shared.topScores()

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(Array(scores.enumerated()), id: \.offset) { index, entry in
                            let (name, score) = entry
                            HStack {
                                Text("\(index + 1).")
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                Text(name)
                                    .font(.body)
                                    .foregroundColor(.primary)

                                Spacer()

                                Text("\(score)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("High Scores")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
            .environmentObject(GameManager())
    }
}
