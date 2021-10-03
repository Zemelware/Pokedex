//
//  Pokemon.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-24.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    var name: String
    let height: Int
    let weight: Int
    let baseExperience: Int
    let sprites: Sprite
    var abilities: [AbilityObject]
    var moves: [MoveObject]
    let stats: [StatObject]
    let types: [TypeObject]
    
    static let example = Pokemon(
        id: 1,
        name: "Bulbasaur Mega Gmax",
        height: 7,
        weight: 69,
        baseExperience: 64,
        sprites: Sprite(other: OtherSprite(officialArtwork: OfficialArtworkSprite(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"))),
        abilities: [AbilityObject(ability: Ability(name: "overgrow")),
                    AbilityObject(ability: Ability(name: "chlorophyll"))],
        moves: [MoveObject(move: Move(name: "razor-wind"))],
        stats: [StatObject(baseStat: 45, stat: Stat(name: "hp")),
                StatObject(baseStat: 49, stat: Stat(name: "attack")),
                StatObject(baseStat: 49, stat: Stat(name: "defense")),
                StatObject(baseStat: 65, stat: Stat(name: "special-attack")),
                StatObject(baseStat: 65, stat: Stat(name: "special-defense")),
                StatObject(baseStat: 45, stat: Stat(name: "speed"))],
        types: [TypeObject(type: ElementType(name: "grass")),
                TypeObject(type: ElementType(name: "poison"))]
    )
}

struct AbilityObject: Codable {
    var ability: Ability
}

struct Ability: Codable {
    var name: String
}

struct MoveObject: Codable {
    var move: Move
}

struct Move: Codable {
    var name: String
}

struct Sprite: Codable {
    let other: OtherSprite
}

struct OtherSprite: Codable {
    let officialArtwork: OfficialArtworkSprite
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork" // Must do this becuase the JSON object uses a dash in the name
    }
}

struct OfficialArtworkSprite: Codable {
    let frontDefault: String?
}

struct StatObject: Codable {
    let baseStat: Int
    let stat: Stat
}

struct Stat: Codable {
    let name: String
}

struct TypeObject: Codable {
    let type: ElementType
}

struct ElementType: Codable {
    let name: String
}
