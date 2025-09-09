//
//  ContentView.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var favoritesManager = FavoritesManager()
    @StateObject private var recipeListViewModel: RecipeListViewModel
    
    init() {
        let dataService = MockDataService()
        let favoritesManager = FavoritesManager()
        self._favoritesManager = StateObject(wrappedValue: favoritesManager)
        self._recipeListViewModel = StateObject(wrappedValue: RecipeListViewModel(dataService: dataService, favoritesManager: favoritesManager))
    }
    
    var body: some View {
        TabView {
            NavigationView {
                RecipeListView(viewModel: recipeListViewModel)
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Recipes")
            }
            
            NavigationView {
                FavoritesView(favoritesManager: favoritesManager)
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }
            
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .accentColor(Color("Orange"))
    }
}

struct FavoritesView: View {
    @StateObject private var viewModel: FavoritesViewModel
    let favoritesManager: FavoritesManager
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
        self._viewModel = StateObject(wrappedValue: FavoritesViewModel(dataService: MockDataService(), favoritesManager: favoritesManager))
    }
    
    var body: some View {
        VStack {
            if viewModel.favoriteRecipes.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "heart")
                        .font(.system(size: 60))
                        .foregroundColor(Color("Orange").opacity(0.6))
                    
                    Text("No Favorite Recipes")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("Add recipes to favorites by tapping the heart")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.favoriteRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe))) {
                                RecipeCell(
                                    recipe: recipe,
                                    isFavorite: viewModel.isFavorite(recipe),
                                    onFavoriteToggle: {
                                        viewModel.toggleFavorite(recipe)
                                    }
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.updateFavoriteRecipes()
        }
    }
}

#Preview {
    ContentView()
}
