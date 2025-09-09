//
//  UserRecipeManager.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation
import Combine

class UserRecipeManager: ObservableObject {
    @Published var userRecipes: [UserRecipe] = []
    
    private let userDefaults = UserDefaults.standard
    private let userRecipesKey = "userRecipes"
    
    init() {
        loadUserRecipes()
    }
    
    func addRecipe(_ recipe: UserRecipe) {
        userRecipes.append(recipe)
        saveUserRecipes()
    }
    
    func updateRecipe(_ recipe: UserRecipe) {
        if let index = userRecipes.firstIndex(where: { $0.id == recipe.id }) {
            userRecipes[index] = recipe
            saveUserRecipes()
        }
    }
    
    func deleteRecipe(_ recipe: UserRecipe) {
        userRecipes.removeAll { $0.id == recipe.id }
        saveUserRecipes()
    }
    
    func getAllRecipes() -> [Recipe] {
        return userRecipes.map { $0.toRecipe() }
    }
    
    private func saveUserRecipes() {
        if let data = try? JSONEncoder().encode(userRecipes) {
            userDefaults.set(data, forKey: userRecipesKey)
        }
    }
    
    private func loadUserRecipes() {
        if let data = userDefaults.data(forKey: userRecipesKey),
           let recipes = try? JSONDecoder().decode([UserRecipe].self, from: data) {
            userRecipes = recipes
        }
    }
}
