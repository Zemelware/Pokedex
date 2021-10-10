//
//  NetworkManager.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func pokemonResults() async throws -> [PokemonURL] {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=10000"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        guard let decodedData = try? JSONDecoder().decode(Results.self, from: data) else { throw NetworkError.invalidData }
        
        return decodedData.results
    }
    
    func pokemon(url: String) async throws -> Pokemon {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decodedData = try? decoder.decode(Pokemon.self, from: data) else { throw NetworkError.invalidData }
        
        return decodedData
    }
}
