//
//  ContentViewModel.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-22.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var pokemonList: [PokemonURL] = []
    @Published var pokemons: [Pokemon] = []
    @Published var alertItem: AlertItem?
        
    func getPokemon() {
        DispatchQueue.main.async {
            Task {
                do {
                    self.pokemonList = try await NetworkManager.shared.pokemonList()
                    for i in 0..<self.pokemonList.count {
                        self.pokemons.append(try await NetworkManager.shared.pokemon(url: self.pokemonList[i].url))
                        
                        // Replace any dashes in the names with spaces
                        self.pokemons[i].name = self.pokemons[i].name.removeDashesAndCapitalize()
                    }
                } catch NetworkError.invalidData {
                    self.alertItem = AlertContext.invalidData
                } catch NetworkError.invalidURL {
                    self.alertItem = AlertContext.invalidURL
                } catch NetworkError.invalidResponse {
                    self.alertItem = AlertContext.invalidResponse
                } catch {
                    self.alertItem = AlertContext.unableToComplete
                }
            }
        }
    }
    
    func searchResults(with searchText: String, showingOnlyMegas onlyMegas: Bool) -> [Pokemon] {
        var filteredPokemons = pokemons

        if onlyMegas { filteredPokemons = pokemons.filter { $0.name.contains(" Mega") } }
        else if searchText.isEmpty { filteredPokemons = pokemons }

        if !searchText.isEmpty {
            filteredPokemons = filteredPokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }

        return filteredPokemons
    }
    
}
