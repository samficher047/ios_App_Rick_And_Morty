import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    @State private var isFavorite = false
    
    @StateObject private var viewModel = CharacterDetailViewModel(
        useCase: GetEpisodesUseCase(api: APIClient())
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(ProgressView())
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipped()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text(character.name)
                        .font(.system(size: 32, weight: .heavy))
                    
                    HStack(spacing: 12) {
                        InfoBadge(title: "Status", value: character.status, color: statusColor(for: character.status))
                        InfoBadge(title: "Species", value: character.species, color: .blue)
                        InfoBadge(title: "Gender", value: character.gender ?? "Unknown", color: .purple)
                    }
                    
                    VStack(spacing: 12) {
                        
                        Button {
                            toggleFavorite()
                        } label: {
                            Label(
                                isFavorite ? "Remove from Favorites" : "Add to Favorites",
                                systemImage: isFavorite ? "heart.fill" : "heart"
                            )
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFavorite ? Color.red : Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .accessibilityIdentifier("favorite_button")
                        
                        NavigationLink {
                            MapView(character: character)
                        } label: {
                            Label("View on Map", systemImage: "map.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Episodes")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else if viewModel.episodes.isEmpty {
                            Text("No episodes found")
                                .foregroundColor(.secondary)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(viewModel.episodes) { episode in
                                    EpisodeRow(episode: episode)
                                }
                            }
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isFavorite = CoreDataManager.shared.isFavorite(id: character.id)
        }
        .task {
            await viewModel.loadEpisodes(from: character.episode)
        }
    }
    
    // MARK: - Actions
    
    private func toggleFavorite() {
        if isFavorite {
            CoreDataManager.shared.deleteFavorite(id: character.id)
        } else {
            CoreDataManager.shared.saveFavorite(character: character)
        }
        isFavorite.toggle()
    }
    
    private func statusColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive": return .green
        case "dead": return .red
        default: return .gray
        }
    }
    
    
    struct InfoBadge: View {
        let title: String
        let value: String
        let color: Color
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title.uppercased())
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    
 
}
