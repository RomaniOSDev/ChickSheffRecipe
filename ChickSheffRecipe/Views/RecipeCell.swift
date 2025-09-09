//
//  RecipeCell.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Изображение рецепта
            ZStack {
                // Основное изображение
                RecipeImageView(imageName: recipe.imageName, size: CGSize(width: 150, height: 60))
                
                // Кнопка избранного
                VStack {
                    HStack {
                        Spacer()
                        Button(action: onFavoriteToggle) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(isFavorite ? Color("WarmRed") : .white)
                                .padding(8)
                                .background(
                                    Circle()
                                        .fill(Color.black.opacity(0.3))
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer()
                }
                .padding(8)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("WarmRed").opacity(0.3), Color("Yellow").opacity(0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            
            // Информация о рецепте
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                        .foregroundColor(Color("WarmRed"))
                    
                    Text(getCookingTimeText())
                        .font(.caption)
                        .foregroundColor(Color("WarmRed"))
                    
                    Spacer()
                    
                    Text(recipe.difficulty)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(getDifficultyColor())
                        )
                }
                
                Text(recipe.category)
                    .font(.caption)
                    .foregroundColor(Color("WarmRed"))
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 4)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemBackground),
                    Color("Yellow").opacity(0.05)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color("WarmRed").opacity(0.2), radius: 6, x: 0, y: 3)
    }
    
    private func getCookingTimeText() -> String {
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
    
    private func getDifficultyColor() -> Color {
        switch recipe.difficulty {
        case "Easy":
            return Color("Yellow")
        case "Medium":
            return Color("Orange")
        case "Hard":
            return Color("WarmRed")
        default:
            return .gray
        }
    }
}

#Preview {
    let sampleRecipe = Recipe.sampleRecipes[0]
    return RecipeCell(
        recipe: sampleRecipe,
        isFavorite: true,
        onFavoriteToggle: {}
    )
    .padding()
    .previewLayout(.sizeThatFits)
}
