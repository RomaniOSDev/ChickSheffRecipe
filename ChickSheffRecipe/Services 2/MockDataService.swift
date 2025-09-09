//
//  MockDataService.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation
import Combine

class MockDataService: DataServiceProtocol, ObservableObject {
    @Published var allRecipes: [Recipe]
    
    private let baseRecipes: [Recipe]
    private let userRecipeManager: UserRecipeManager
    
    init() {
        self.baseRecipes = Recipe.sampleRecipes
        self.userRecipeManager = UserRecipeManager()
        self.allRecipes = baseRecipes + userRecipeManager.getAllRecipes()
        
        // Подписываемся на изменения пользовательских рецептов
        userRecipeManager.$userRecipes
            .sink { [weak self] _ in
                self?.updateAllRecipes()
            }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRecipes() -> [Recipe] {
        return allRecipes
    }
    
    func fetchRecipes(for category: String) -> [Recipe] {
        if category == "Все" {
            return allRecipes
        }
        return allRecipes.filter { $0.category == category }
    }
    
    func addUserRecipe(_ recipe: UserRecipe) {
        userRecipeManager.addRecipe(recipe)
    }
    
    func updateUserRecipe(_ recipe: UserRecipe) {
        userRecipeManager.updateRecipe(recipe)
    }
    
    func deleteUserRecipe(_ recipe: UserRecipe) {
        userRecipeManager.deleteRecipe(recipe)
    }
    
    private func updateAllRecipes() {
        allRecipes = baseRecipes + userRecipeManager.getAllRecipes()
    }
}
