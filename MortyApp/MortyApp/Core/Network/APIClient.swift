import Foundation

final class APIClient: APIClientProtocol {
    private let baseURL = "https://rickandmortyapi.com/api"
    

    
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?
    ) async throws -> CharacterResponseDTO {
        
        var components = URLComponents(string: "https://rickandmortyapi.com/api/character")!
        
        var queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        
        if let status = status, !status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
        
        if let species = species, !species.isEmpty {
            queryItems.append(URLQueryItem(name: "species", value: species))
        }
        
        components.queryItems = queryItems
        
        let url = components.url!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
    }
    
    
    func fetchEpisode(id: Int) async throws -> Episode {
        let url = URL(string: "https://rickandmortyapi.com/api/episode/\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let dto = try JSONDecoder().decode(EpisodeDTO.self, from: data)
        
        return dto.toDomain()
    }
}
