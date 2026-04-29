//
//  CharacterUseCaseTests.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//

import XCTest
@testable import MortyApp

@MainActor
final class CharacterUseCaseTests: XCTestCase {
    
    func test_useCase_returnsCharacters() async throws {
        
        let mockAPI = MockAPIClient()
        let repository = CharacterRepository(api: mockAPI)
        let useCase = GetCharactersUseCase(repository: repository)
        
        let result = try await useCase.execute(
            page: 1,
            name: nil,
            status: nil,
            species: nil
        )
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Rick Sanchez")
    }
}
