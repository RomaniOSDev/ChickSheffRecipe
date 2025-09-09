//
//  FavoritesManager.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    @Published var favoriteRecipeIds: Set<UUID> = []
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favoriteRecipeIds"
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(_ recipe: Recipe) {
        if isFavorite(recipe) {
            removeFromFavorites(recipe)
        } else {
            addToFavorites(recipe)
        }
    }
    
    func addToFavorites(_ recipe: Recipe) {
        favoriteRecipeIds.insert(recipe.id)
        saveFavorites()
    }
    
    func removeFromFavorites(_ recipe: Recipe) {
        favoriteRecipeIds.remove(recipe.id)
        saveFavorites()
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        return favoriteRecipeIds.contains(recipe.id)
    }
    
    func getFavoriteRecipes(from allRecipes: [Recipe]) -> [Recipe] {
        return allRecipes.filter { isFavorite($0) }
    }
    
    private func saveFavorites() {
        let ids = Array(favoriteRecipeIds).map { $0.uuidString }
        userDefaults.set(ids, forKey: favoritesKey)
    }
    
    private func loadFavorites() {
        if let idStrings = userDefaults.array(forKey: favoritesKey) as? [String] {
            favoriteRecipeIds = Set(idStrings.compactMap { UUID(uuidString: $0) })
        }
    }
}
