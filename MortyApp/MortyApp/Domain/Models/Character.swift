//
//  Character.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//

struct Character: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String?
    let episode: [String]
}
