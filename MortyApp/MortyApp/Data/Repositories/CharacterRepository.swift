final class CharacterRepository {
    private let api: APIClientProtocol
    
    init(api: APIClientProtocol) {
        self.api = api
    }
    
    func getCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?
    ) async throws -> [Character] {
        
        let response = try await api.fetchCharacters(
            page: page,
            name: name,
            status: status,
            species: species
        )
        
        return response.results.map {
            Character(
                id: $0.id,
                name: $0.name,
                status: $0.status,
                species: $0.species,
                image: $0.image,
                gender: $0.gender,
                episode: $0.episode
            )
        }
    }
}
