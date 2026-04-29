//
//  MockAPIClient.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//

import Foundation
@testable import MortyApp

final class MockAPIClient: APIClientProtocol {
    
    var shouldThrowError = false
    
    var mockResponse: CharacterResponseDTO = CharacterResponseDTO(
        results: [
            CharacterDTO(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                image: "https://image.com/rick.png",
                gender: "Male",
                episode: []
            )
        ]
    )
    
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?
    ) async throws -> CharacterResponseDTO {
        
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        
        return mockResponse
    }
}
