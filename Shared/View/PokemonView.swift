//
//  PokemonView.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-24.
//

import SwiftUI

struct PokemonView: View {
    
    @StateObject private var viewModel = PokemonViewModel()
    
    let pokemon: Pokemon
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .offset(y: 190)
                .shadow(color: .black.opacity(0.3), radius: 15)
            
            VStack {
                Text(pokemon.name)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                
                pokemonImage
                
                ScrollView {
                    HStack {
                        pokemonTypes
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        
                        Text("Height: \(viewModel.decToFeetInches(Double(pokemon.height)))")
                        Text("Weight: \(viewModel.hgToPounds(Double(pokemon.weight)))")
                        Text("Base experience: \(pokemon.baseExperience)")
                        
                        pokemonStats
                        
//                        Text("Abilities: \(pokemon.abilities[0].ability.name.removeDashesAndCapitalize())")
//                        Text("Moves: \(pokemon.moves[0].move.name.removeDashesAndCapitalize())")

                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                }.padding(.top, 5)
            }
        }
        .background(viewModel.bgColor(forType: pokemon.types[0].type.name))
    }
    
    var pokemonImage: some View {
        AsyncImage(url: URL(string: pokemon.sprites.other.officialArtwork.frontDefault ?? "")) { image in
            image
                .resizable()
                .frame(width: 200, height: 200)
        } placeholder: {
            Rectangle()
                .background(.regularMaterial)
                .cornerRadius(20)
                .overlay {
                    Text(pokemon.sprites.other.officialArtwork.frontDefault == nil ? "No image for this Pokemon" : "Loading...")
                        .foregroundColor(.white)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                }
        }
        .frame(width: 185, height: 170)
    }
    
    var pokemonTypes: some View {
        ForEach(pokemon.types, id: \.type.name) { typeObject in
            Text(typeObject.type.name.capitalized)
                .bold()
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(viewModel.bgColor(forType: typeObject.type.name))
                .cornerRadius(.infinity)
        }
    }
    
    var pokemonStats: some View {
        VStack(alignment: .leading) {
            ForEach(pokemon.stats, id: \.stat.name) { statObject in
                HStack {
                    // If the stat is "hp", capitalize both letters
                    Text(statObject.stat.name == "hp" ? "HP" : statObject.stat.name.removeDashesAndCapitalize())
                        .frame(width: 65, alignment: .leading)
                    
                    GeometryReader { geo in
                        let barWidth = geo.size.width * CGFloat(Double(statObject.baseStat)/255)
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundColor(viewModel.bgColor(forType: pokemon.types.count == 2 ?
                                                               pokemon.types[1].type.name :
                                                               pokemon.types[0].type.name))
                            .frame(width: barWidth)
                            .position(x: barWidth/2, y: geo.size.height/2)
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 1, y: 0)
                            .overlay(alignment: .leading) {
                                Text("\(statObject.baseStat)")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.leading, 7)
                            }
                    }
                    .background(.ultraThinMaterial)
                    .frame(height: 30)
                    .cornerRadius(.infinity)
                }

            }
        }
    }
    
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemon: Pokemon.example)
    }
}
