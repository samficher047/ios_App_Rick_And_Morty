//
//  CharacterListViewModelTests.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//

import XCTest
@testable import MortyApp

@MainActor
final class CharacterListViewModelTests: XCTestCase {
    
    func test_loadCharacters_success() async {
        
        let mockAPI = MockAPIClient()
        let repository = CharacterRepository(api: mockAPI)
        let useCase = GetCharactersUseCase(repository: repository)
        
        let viewModel = CharacterListViewModel(useCase: useCase)
        
        await viewModel.loadCharacters()
        
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_search_resetsPage_andUpdatesData() async {
        
        let mockAPI = MockAPIClient()
        let repository = CharacterRepository(api: mockAPI)
        let useCase = GetCharactersUseCase(repository: repository)
        
        let viewModel = CharacterListViewModel(useCase: useCase)
        
        viewModel.searchText = "Rick"
        viewModel.search()
        
        try? await Task.sleep(nanoseconds: 600_000_000)
        
        XCTAssertEqual(viewModel.characters.count, 1)
    }
    
    func test_errorHandling_setsErrorMessage() async {
        
        let mockAPI = MockAPIClient()
        mockAPI.shouldThrowError = true
        
        let repository = CharacterRepository(api: mockAPI)
        let useCase = GetCharactersUseCase(repository: repository)
        
        let viewModel = CharacterListViewModel(useCase: useCase)
        
        await viewModel.loadCharacters()
        
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
