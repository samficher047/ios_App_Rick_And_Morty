//
//  CharacterRepositoryTests.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//

import XCTest
@testable import MortyApp

final class CharacterRepositoryTests: XCTestCase {
    
    func test_getCharacters_returnsMappedData() async throws {
        
        let mockAPI = MockAPIClient()
        
        let repository = CharacterRepository(api: mockAPI)
        
        let result = try await repository.getCharacters(
            page: 1,
            name: nil,
            status: nil,
            species: nil
        )
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Rick Sanchez")
    }
    
    func test_getCharacters_whenError_shouldThrow() async {
        
        let mockAPI = MockAPIClient()
        mockAPI.shouldThrowError = true
        
        let repository = CharacterRepository(api: mockAPI)
        
        do {
            _ = try await repository.getCharacters(
                page: 1,
                name: nil,
                status: nil,
                species: nil
            )
            XCTFail("Should have thrown error")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
