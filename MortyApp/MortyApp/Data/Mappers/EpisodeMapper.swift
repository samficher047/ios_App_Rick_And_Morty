//
//  EpisodeMapper.swift
//  MortyApp
//
//  Created by angel aquino on 29/04/26.
//

extension EpisodeDTO {
    func toDomain() -> Episode {
        Episode(
            id: id,
            name: name,
            episode: episode
        )
    }
}
