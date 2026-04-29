//
//  CharacterDetailViewModel.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//
import Foundation
import Combine


@MainActor
final class CharacterDetailViewModel: ObservableObject {
    
    @Published var episodes: [Episode] = []
    @Published var isLoading = false
    
    private let useCase: GetEpisodesUseCase
    
    init(useCase: GetEpisodesUseCase) {
        self.useCase = useCase
    }
    
    func loadEpisodes(from urls: [String]) async {
        isLoading = true
        
        do {
            let ids = urls.compactMap { url in
                Int(url.split(separator: "/").last ?? "")
            }
            
            episodes = try await useCase.execute(ids: ids)
            
        } catch {
            print("Error loading episodes:", error)
        }
        
        isLoading = false
    }
}
