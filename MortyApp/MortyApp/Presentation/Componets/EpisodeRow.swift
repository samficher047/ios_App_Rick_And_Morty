import SwiftUI

struct EpisodeRow: View {
    let episode: Episode
    
    @State private var isWatched = false
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 6) {
                Text(episode.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(episode.episode)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                //print("tap episodio:", episode.id)
                toggleWatched()
            } label: {
                Image(systemName: isWatched ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isWatched ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(.plain)
        }
        .contentShape(Rectangle())
        .padding(12)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            isWatched = CoreDataManager.shared.isEpisodeWatched(id: episode.id)
        }
    }
    
    private func toggleWatched() {
        if isWatched {
            CoreDataManager.shared.deleteWatchedEpisode(id: episode.id)
        } else {
            CoreDataManager.shared.saveWatchedEpisode(episode)
        }
        
        isWatched.toggle()
    }
}
