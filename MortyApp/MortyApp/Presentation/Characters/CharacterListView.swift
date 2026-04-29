import SwiftUI

struct CharacterListView: View {
    
    @StateObject var viewModel: CharacterListViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.characters.isEmpty {
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else if let error = viewModel.errorMessage {
                        
                        VStack(spacing: 12) {
                            Text("Error")
                                .font(.headline)
                            
                            Text(error)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                            
                            Button("Retry") {
                                Task { await viewModel.refresh() }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else {
                        Text("No results found")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                } else {
                    VStack {
                        
                        HStack {
                            Menu {
                                Button("All") { viewModel.selectedStatus = "" }
                                Button("Alive") { viewModel.selectedStatus = "alive" }
                                Button("Dead") { viewModel.selectedStatus = "dead" }
                                Button("Unknown") { viewModel.selectedStatus = "unknown" }
                            } label: {
                                Label(
                                    viewModel.selectedStatus.isEmpty ? "Status" : viewModel.selectedStatus.capitalized,
                                    systemImage: "line.3.horizontal.decrease.circle"
                                )
                            }
                            Menu {
                                Button("All") { viewModel.selectedSpecies = "" }
                                Button("Human") { viewModel.selectedSpecies = "human" }
                                Button("Alien") { viewModel.selectedSpecies = "alien" }
                            } label: {
                                Label(
                                    viewModel.selectedSpecies.isEmpty ? "Species" : viewModel.selectedSpecies.capitalized,
                                    systemImage: "line.3.horizontal.decrease.circle"
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    List(viewModel.characters) { character in
                        
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            
                            HStack(alignment: .top, spacing: 12) {
                                
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(character.name)
                                        .font(.headline)
                                    
                                    Text(character.species)
                                        .font(.subheadline)
                                    
                                    Text(character.status)
                                        .font(.caption)
                                }
                            }
                        }
                        .onAppear {
                            if character.id == viewModel.characters.last?.id {
                                Task {
                                    await viewModel.loadNextPage()
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Characters")
            
            .searchable(text: $viewModel.searchText)
            .accessibilityIdentifier("search_field")
            
            .onChange(of: viewModel.selectedStatus) {
                viewModel.search()
            }

            .onChange(of: viewModel.selectedSpecies) {
                viewModel.search()
            }
            
            .onChange(of: viewModel.searchText) {
                viewModel.search()
            }
            
            .refreshable {
                await viewModel.refresh()
            }
            
            .task {
                if viewModel.characters.isEmpty {
                    await viewModel.initialLoad()
                }
            }
            
            .toolbar {
                NavigationLink {
                    FavoritesView()
                } label: {
                    Image(systemName: "heart.fill")
                }
            }
        }
    }
}
