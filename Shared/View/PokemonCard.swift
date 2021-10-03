//
//  PokemonCard.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-22.
//

import SwiftUI

struct PokemonCard: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            Text(pokemon.name)
                .font(.title2)
                .bold()
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
            AsyncImage(url: URL(string: pokemon.sprites.other.officialArtwork.frontDefault ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
            } placeholder: {
                Color(uiColor: .lightGray)
                    .cornerRadius(20)
                    .opacity(0.4)
            }
            .frame(width: 100, height: 100)
        }
        .foregroundColor(.white)
        .frame(minWidth: 130, maxWidth: 180)
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(lineWidth: 0.5)
                .fill(.white)
        }
    }
}

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(pokemon: Pokemon.example)
            .preferredColorScheme(.dark)
    }
}
