struct CharacterResponseDTO: Decodable {
    let results: [CharacterDTO]
}

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let episode: [String]
}

 
