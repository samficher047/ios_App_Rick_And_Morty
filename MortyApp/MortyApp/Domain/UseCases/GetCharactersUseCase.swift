final class GetCharactersUseCase {
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func execute(
        page: Int,
        name: String? = nil,
        status: String? = nil,
        species: String? = nil
    ) async throws -> [Character] {
        
        try await repository.getCharacters(
            page: page,
            name: name,
            status: status,
            species: species
        )
    }
    
    
}
