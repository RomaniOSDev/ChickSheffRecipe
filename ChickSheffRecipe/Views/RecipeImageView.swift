//
//  RecipeImageView.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import SwiftUI

struct RecipeImageView: View {
    let imageName: String
    let size: CGSize
    @State private var imageLoadFailed = false
    
    init(imageName: String, size: CGSize = CGSize(width: 200, height: 120)) {
        self.imageName = imageName
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Пытаемся загрузить реальное изображение
            if hasRealImage && !imageLoadFailed {
                Image(actualImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .cornerRadius(12)
                    .onAppear {
                        imageLoadFailed = false
                    }
            } else {
                // Цветная заглушка с градиентом, если реального изображения нет
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.7)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size.width, height: size.height)
                
                // Иконка рецепта
                VStack {
                    Image(systemName: iconName)
                        .font(.system(size: min(size.width, size.height) * 0.25))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    
                    Text(categoryName)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0.5, y: 0.5)
                }
            }
        }
    }
    
    private var hasRealImage: Bool {
        // Проверяем, есть ли реальное изображение в Assets
        // Также проверяем альтернативные имена файлов
        let possibleNames = [imageName, "Image"] // для chicken_soup
        return possibleNames.contains { UIImage(named: $0) != nil }
    }
    
    private var actualImageName: String {
        // Возвращаем правильное имя изображения
        if UIImage(named: imageName) != nil {
            return imageName
        } else if UIImage(named: "Image") != nil && imageName == "chicken_soup" {
            return "Image"
        }
        return imageName
    }
    
    private var categoryName: String {
        switch imageName {
        case "chicken_oven":
            return "Oven"
        case "chicken_breast":
            return "Pan"
        case "chicken_soup":
            return "Soup"
        case "caesar_salad":
            return "Salad"
        case "chicken_wings":
            return "Oven"
        case "chicken_nuggets":
            return "Pan"
        case "chicken_pilaf":
            return "Pan"
        case "chicken_curry":
            return "Pan"
        case "chicken_avocado_salad":
            return "Salad"
        case "chicken_patties":
            return "Pan"
        case "chicken_broth":
            return "Soup"
        case "chicken_cream_sauce":
            return "Pan"
        default:
            return "Recipe"
        }
    }
    
    private var backgroundColor: Color {
        switch imageName {
        case "chicken_oven":
            return Color("WarmRed")
        case "chicken_breast":
            return Color("Yellow")
        case "chicken_soup":
            return Color("Red")
        case "caesar_salad":
            return Color("GoldenYellow")
        case "chicken_wings":
            return Color("WarmRed")
        case "chicken_nuggets":
            return Color("Yellow")
        case "chicken_pilaf":
            return Color("Red")
        case "chicken_curry":
            return Color("GoldenYellow")
        case "chicken_avocado_salad":
            return Color("Yellow")
        case "chicken_patties":
            return Color("WarmRed")
        case "chicken_broth":
            return Color("Red")
        case "chicken_cream_sauce":
            return Color("GoldenYellow")
        default:
            return Color("WarmRed")
        }
    }
    
    private var iconName: String {
        switch imageName {
        case "chicken_oven":
            return "oven.fill"
        case "chicken_breast":
            return "flame.fill"
        case "chicken_soup":
            return "drop.fill"
        case "caesar_salad":
            return "leaf.fill"
        case "chicken_wings":
            return "bird.fill"
        case "chicken_nuggets":
            return "circle.grid.3x3.fill"
        case "chicken_pilaf":
            return "rice.fill"
        case "chicken_curry":
            return "sparkles"
        case "chicken_avocado_salad":
            return "heart.fill"
        case "chicken_patties":
            return "circle.fill"
        case "chicken_broth":
            return "cup.and.saucer.fill"
        case "chicken_cream_sauce":
            return "drop.circle.fill"
        default:
            return "photo"
        }
    }
}

#Preview {
    VStack {
        RecipeImageView(imageName: "chicken_oven")
        RecipeImageView(imageName: "chicken_soup")
        RecipeImageView(imageName: "caesar_salad")
    }
    .padding()
}
