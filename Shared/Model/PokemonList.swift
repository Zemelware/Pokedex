//
//  Pokemon.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-22.
//

import Foundation

struct Results: Codable {
    let count: Int
    let results: [PokemonURL]
}

struct PokemonURL: Codable {
    let name: String
    let url: String
}
