//
//  ContentView.swift
//  Shared
//
//  Created by Ethan Zemelman on 2021-09-22.
//  API Link: https://pokeapi.co

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var searchText = ""
    @State private var filteringMegas = false
    @State private var filteringGmaxes = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                background.ignoresSafeArea()
                
                ScrollViewReader { proxy in
                    ScrollView {
                        HStack {
                            Spacer()
                            pokemonGrid
                            Spacer()
                        }.padding(.horizontal, 8)
                    }.overlay(alignment: .bottomTrailing) {
                        HStack {
                            Button {
                                withAnimation {
                                    proxy.scrollTo(viewModel.pokemons.last?.id ?? 0, anchor: .bottom)
                                }
                            } label: {
                                Image(systemName: "arrow.down.to.line")
                                    .foregroundStyle(.gray, .white)
                                    .font(.largeTitle)
                                    .padding(.leading)
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                            }
                            Spacer()
                            filterButton
                        }
                        .padding(.bottom)
                        .frame(height: 50)
                    }
                }
            }
            .navigationTitle("Pokemon")
        }
        .accentColor(.cyan)
        .searchable(text: $searchText, prompt: "Search a Pokemon")
        .disableAutocorrection(true)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .task { viewModel.getPokemon() }
    }
    
    var pokemonGrid: some View {
        VStack {
            if viewModel.searchResults(with: searchText, filterMegas: filteringMegas, filterGmaxes: filteringGmaxes).isEmpty {
                VStack {
                    Text("No Results")
                        .font(.title2)
                        .bold()
                    Text("Try a new search or wait for the results to load.")
                        .font(.body)
                        .foregroundColor(.secondary)
//                    ProgressView(value: viewModel.loadedCount, total: Double(viewModel.pokemonResults.count))
                    Text("\(viewModel.loadedCount)")
                }.frame(height: UIScreen.main.bounds.height/2)
            } else {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.searchResults(with: searchText, filterMegas: filteringMegas, filterGmaxes: filteringGmaxes)) { pokemon in
                        NavigationLink {
                            PokemonView(pokemon: pokemon)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            PokemonCard(pokemon: pokemon)
                                .shadow(color: .black.opacity(0.2), radius: 7, x: 0, y: 4)
                        }
                    }
                }
            }
        }
    }
    
    var filterButton: some View {
        Menu {
            Button(action: { filteringMegas.toggle() }) {
                Label("Filter Megas", systemImage: filteringMegas ? "checkmark" : "")
            }
            Button(action: { filteringGmaxes.toggle() }) {
                Label("Filter G-Maxes", systemImage: filteringGmaxes ? "checkmark" : "")
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .font(.system(size: 50))
                .padding(.trailing)
                .symbolVariant(.circle.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.thinMaterial, .cyan)
        }
    }
    
    var background: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.6156020355, green: 0.4252334919, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))]), center: .center, angle: .degrees(260))
            Circle()
                .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                .frame(width: 300, height: 300)
                .blur(radius: 60)
            LinearGradient(colors: [.white.opacity(0.7), .white.opacity(0.1)], startPoint: .top, endPoint: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
