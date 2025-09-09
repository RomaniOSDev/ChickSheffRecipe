//
//  RecipeListView.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeListViewModel
    @State private var showingAddRecipe = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Поиск
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search recipes...", text: $viewModel.searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !viewModel.searchText.isEmpty {
                    Button("Clear") {
                        viewModel.searchText = ""
                    }
                    .font(.caption)
                    .foregroundColor(.orange)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 8)
            
            // Фильтр по категориям
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        CategoryButton(
                            title: category,
                            isSelected: viewModel.selectedCategory == category || (viewModel.selectedCategory == nil && category == "Все")
                        ) {
                            viewModel.filterRecipes(by: category)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            
            // Список рецептов
            if viewModel.isLoading {
                Spacer()
                ProgressView("Loading recipes...")
                    .font(.headline)
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.filteredRecipes) { recipe in
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
        .navigationTitle("Chicken Chef")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddRecipe = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color("Orange"))
                }
            }
        }
        .onAppear {
            viewModel.refreshRecipes()
        }
        .sheet(isPresented: $showingAddRecipe) {
            AddRecipeView(dataService: viewModel.dataService as! MockDataService)
                .onDisappear {
                    viewModel.refreshRecipes()
                }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color("Orange") : Color(.systemGray5))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationView {
        RecipeListView(viewModel: RecipeListViewModel(dataService: MockDataService(), favoritesManager: FavoritesManager()))
    }
}
