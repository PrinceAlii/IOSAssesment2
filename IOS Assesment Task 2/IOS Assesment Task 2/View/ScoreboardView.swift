import SwiftUI

struct ScoreboardView: View {
    @Environment(\.presentationMode) private var presentationMode
    private let scores = Score.shared.topScores()
    
    var body: some View {
        VStack(spacing: 24) {
            Text("High Scores")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Array(scores.enumerated()), id: \.offset) { idx, entry in
                        HStack {
                            Text("\(idx+1).").bold()
                            Text(entry.0)
                            Spacer()
                            Text("\(entry.1)")
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                        .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
            }
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}
