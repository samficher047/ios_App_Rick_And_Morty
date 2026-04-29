//
//  APIClientProtocol.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//
import Foundation

protocol APIClientProtocol {
    
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?
    ) async throws -> CharacterResponseDTO
}
