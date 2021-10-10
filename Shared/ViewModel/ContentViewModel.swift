//
//  ContentViewModel.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-22.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var pokemonResults = Results(count: 0, results: [PokemonURL]())
    @State var loadedCount = 0.0
    @Published var pokemonList: [PokemonURL] = []
    @Published var pokemons: [Pokemon] = []
    @Published var alertItem: AlertItem?
    
    func getPokemon() {
        DispatchQueue.main.async {
            Task {
                do {
                    self.pokemonResults = try await NetworkManager.shared.pokemonResults()
                    self.pokemonList = self.pokemonResults.results
                    for i in 0..<self.pokemonList.count {
                        self.pokemons.append(try await NetworkManager.shared.pokemon(url: self.pokemonList[i].url))
                        
                        // Replace any dashes in the names with spaces & change "Gmax" to "G-Max"
                        self.pokemons[i].name = self.pokemons[i].name.removeDashesAndCapitalize().formatGmax()
                        
                        self.loadedCount = Double(i)
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
    
    func searchResults(with searchText: String, filterMegas filteringMegas: Bool, filterGmaxes filteringGmaxes: Bool) -> [Pokemon] {
        var filteredPokemons = pokemons

        if filteringMegas || filteringGmaxes {
            filteredPokemons = pokemons.filter { pokemon in
                if filteringMegas && filteringGmaxes {
                    return pokemon.name.contains(" Mega") || pokemon.name.contains("G-Max")
                } else {
                    if filteringMegas {
                        return pokemon.name.contains(" Mega")
                    }
                    if filteringGmaxes {
                        return pokemon.name.contains("G-Max")
                    }
                }
                return false
            }
        }
        else if searchText.isEmpty { filteredPokemons = pokemons }

        if !searchText.isEmpty {
            filteredPokemons = filteredPokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }

        return filteredPokemons
    }
    
}
