//
//  FavoritesViewModel.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoriteRecipes: [Recipe] = []
    
    private let dataService: DataServiceProtocol
    private let favoritesManager: FavoritesManager
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: DataServiceProtocol, favoritesManager: FavoritesManager) {
        self.dataService = dataService
        self.favoritesManager = favoritesManager
        
        // Подписываемся на изменения избранных
        favoritesManager.$favoriteRecipeIds
            .sink { [weak self] _ in
                self?.updateFavoriteRecipes()
            }
            .store(in: &cancellables)
        
        updateFavoriteRecipes()
    }
    
    func toggleFavorite(_ recipe: Recipe) {
        favoritesManager.toggleFavorite(recipe)
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        return favoritesManager.isFavorite(recipe)
    }
    
    func updateFavoriteRecipes() {
        let allRecipes = dataService.fetchRecipes()
        favoriteRecipes = favoritesManager.getFavoriteRecipes(from: allRecipes)
    }
}
