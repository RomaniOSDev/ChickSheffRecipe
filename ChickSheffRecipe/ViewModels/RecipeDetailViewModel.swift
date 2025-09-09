//
//  RecipeDetailViewModel.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation
import Combine

class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var showCookingCompleteAlert = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func markAsCooked() {
        showCookingCompleteAlert = true
    }
    
    func getCookingTimeText() -> String {
        if recipe.cookingTime < 60 {
            return "\(recipe.cookingTime) min"
        } else {
            let hours = recipe.cookingTime / 60
            let minutes = recipe.cookingTime % 60
            if minutes == 0 {
                return "\(hours) h"
            } else {
                return "\(hours) h \(minutes) min"
            }
        }
    }
    
    func getDifficultyColor() -> String {
        switch recipe.difficulty {
        case "Easy":
            return "green"
        case "Medium":
            return "orange"
        case "Hard":
            return "red"
        default:
            return "gray"
        }
    }
}
