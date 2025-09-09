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
                    .foregroundColor(Color("WarmRed"))
                
                TextField("Search recipes...", text: $viewModel.searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !viewModel.searchText.isEmpty {
                    Button("Clear") {
                        viewModel.searchText = ""
                    }
                    .font(.caption)
                    .foregroundColor(Color("WarmRed"))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("Yellow").opacity(0.3),
                                Color("Orange").opacity(0.2)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: Color("WarmRed").opacity(0.2), radius: 5, x: 0, y: 2)
            )
            .padding(.horizontal)
            .padding(.top, 8)
            
            // Фильтр по категориям
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        CategoryButton(
                            title: category,
                            isSelected: viewModel.selectedCategory == category || (viewModel.selectedCategory == nil && category == "All")
                        ) {
                            viewModel.filterRecipes(by: category)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("Red").opacity(0.1),
                        Color("Yellow").opacity(0.1)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            
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
                .foregroundColor(isSelected ? .white : Color("WarmRed"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            isSelected ? 
                            LinearGradient(
                                gradient: Gradient(colors: [Color("WarmRed"), Color("Red")]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ) :
                            LinearGradient(
                                gradient: Gradient(colors: [Color("Yellow").opacity(0.3), Color("Orange").opacity(0.2)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: isSelected ? Color("WarmRed").opacity(0.3) : Color.clear, radius: 3, x: 0, y: 2)
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
