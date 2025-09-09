//
//  UserRecipe.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation

struct UserRecipe: Identifiable, Codable {
    let id = UUID()
    var title: String
    var ingredients: [String]
    var steps: [String]
    var cookingTime: Int
    var difficulty: String
    var category: String
    var imageName: String
    var dateCreated: Date
    var isUserCreated: Bool
    
    init(title: String, ingredients: [String], steps: [String], cookingTime: Int, difficulty: String, category: String, imageName: String = "photo") {
        self.title = title
        self.ingredients = ingredients
        self.steps = steps
        self.cookingTime = cookingTime
        self.difficulty = difficulty
        self.category = category
        self.imageName = imageName
        self.dateCreated = Date()
        self.isUserCreated = true
    }
}

// MARK: - Conversion to Recipe
extension UserRecipe {
    func toRecipe() -> Recipe {
        return Recipe(
            title: title,
            ingredients: ingredients,
            steps: steps,
            cookingTime: cookingTime,
            difficulty: difficulty,
            category: category,
            imageName: imageName
        )
    }
}

// MARK: - Conversion from Recipe
extension Recipe {
    func toUserRecipe() -> UserRecipe {
        return UserRecipe(
            title: title,
            ingredients: ingredients,
            steps: steps,
            cookingTime: cookingTime,
            difficulty: difficulty,
            category: category,
            imageName: imageName
        )
    }
}
