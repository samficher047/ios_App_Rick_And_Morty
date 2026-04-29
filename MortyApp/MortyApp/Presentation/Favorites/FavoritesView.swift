import SwiftUI

struct FavoritesView: View {
    
    @State private var favorites: [FavoriteCharacter] = []
    @State private var isUnlocked = false
    @State private var showError = false
    
    var body: some View {
        
        Group {
            if isUnlocked {
                List(favorites, id: \.id) { fav in
                    HStack {
                        AsyncImage(url: URL(string: fav.image ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        
                        Text(fav.name ?? "")
                    }
                }
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "lock.fill")
                        .font(.largeTitle)
                    
                    Text("Locked")
                        .font(.headline)
                    
                    Button("Unlock") {
                        authenticate()
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            authenticate()
        }
        .alert("Authentication Failed", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        }
    }
    
    private func authenticate() {
        BiometricAuthManager.shared.authenticate { success in
            if success {
                isUnlocked = true
                favorites = CoreDataManager.shared.fetchFavorites()
            } else {
                showError = true
            }
        }
    }
}
