//
//  RecipeListViewModel.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation
import Combine

class RecipeListViewModel: ObservableObject {
    @Published var allRecipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var selectedCategory: String? = nil
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    let dataService: DataServiceProtocol
    private let favoritesManager: FavoritesManager
    private var cancellables = Set<AnyCancellable>()
    
    let categories = ["All", "Oven", "Pan", "Soup", "Salad"]
    
    init(dataService: DataServiceProtocol, favoritesManager: FavoritesManager) {
        self.dataService = dataService
        self.favoritesManager = favoritesManager
        loadRecipes()
        setupSearchBinding()
        setupDataServiceBinding()
    }
    
    func loadRecipes() {
        isLoading = true
        allRecipes = dataService.fetchRecipes()
        applyFilters()
        isLoading = false
    }
    
    func refreshRecipes() {
        loadRecipes()
    }
    
    func filterRecipes(by category: String) {
        selectedCategory = category
        applyFilters()
    }
    
    func toggleFavorite(_ recipe: Recipe) {
        favoritesManager.toggleFavorite(recipe)
    }
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        return favoritesManager.isFavorite(recipe)
    }
    
    func getFavoriteRecipes() -> [Recipe] {
        return favoritesManager.getFavoriteRecipes(from: allRecipes)
    }
    
    private func setupSearchBinding() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }
    
    private func setupDataServiceBinding() {
        // Подписываемся на изменения в dataService, если это MockDataService
        if let mockDataService = dataService as? MockDataService {
            mockDataService.$allRecipes
                .sink { [weak self] _ in
                    self?.loadRecipes()
                }
                .store(in: &cancellables)
        }
    }
    
    private func applyFilters() {
        var recipes = allRecipes
        
        // Фильтр по категории
        if let category = selectedCategory, category != "All" {
            recipes = dataService.fetchRecipes(for: category)
        }
        
        // Фильтр по поиску
        if !searchText.isEmpty {
            recipes = recipes.filter { recipe in
                recipe.title.localizedCaseInsensitiveContains(searchText) ||
                recipe.ingredients.joined().localizedCaseInsensitiveContains(searchText) ||
                recipe.category.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        filteredRecipes = recipes
    }
}
