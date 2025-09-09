//
//  DataServiceProtocol.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation

protocol DataServiceProtocol {
    func fetchRecipes() -> [Recipe]
    func fetchRecipes(for category: String) -> [Recipe]
    func addUserRecipe(_ recipe: UserRecipe)
    func updateUserRecipe(_ recipe: UserRecipe)
    func deleteUserRecipe(_ recipe: UserRecipe)
}
