//
//  MortyAppApp.swift
//  MortyApp
//
//  Created by angel aquino on 28/04/26.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    var body: some Scene {
        WindowGroup {
            
            let api = APIClient()
            let repo = CharacterRepository(api: api)
            let useCase = GetCharactersUseCase(repository: repo)
            
            CharacterListView(
                viewModel: CharacterListViewModel(useCase: useCase)
            )
        }
    }
}
