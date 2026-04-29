//
//  GetEpisodesUseCase.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//

final class GetEpisodesUseCase {
    
    private let api: APIClient
    
    init(api: APIClient) {
        self.api = api
    }
    
    func execute(ids: [Int]) async throws -> [Episode] {
        
        return try await withThrowingTaskGroup(of: Episode.self) { group in
            
            for id in ids {
                group.addTask {
                    try await self.api.fetchEpisode(id: id)
                }
            }
            
            var episodes: [Episode] = []
            
            for try await episode in group {
                episodes.append(episode)
            }
            
            return episodes.sorted { $0.id < $1.id }
        }
    }
}
