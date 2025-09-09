//
//  Recipe.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import Foundation

struct Recipe: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let ingredients: [String]
    let steps: [String]
    let cookingTime: Int // in minutes
    let difficulty: String
    let category: String
    let imageName: String
    
    init(title: String, ingredients: [String], steps: [String], cookingTime: Int, difficulty: String, category: String, imageName: String) {
        self.title = title
        self.ingredients = ingredients
        self.steps = steps
        self.cookingTime = cookingTime
        self.difficulty = difficulty
        self.category = category
        self.imageName = imageName
    }
}

// MARK: - Sample Data
extension Recipe {
    static let sampleRecipes: [Recipe] = [
        Recipe(
            title: "Roasted Chicken with Potatoes",
            ingredients: [
                "1 whole chicken (1.5-2 kg)",
                "1 kg potatoes",
                "2 onions",
                "4 garlic cloves",
                "3 tbsp vegetable oil",
                "Salt, pepper to taste",
                "Herbs: rosemary, thyme"
            ],
            steps: [
                "Preheat oven to 200°C",
                "Peel potatoes and cut into large pieces",
                "Rub chicken with salt, pepper and herbs",
                "Place potatoes in baking dish",
                "Place chicken on top, breast side up",
                "Bake for 1.5 hours, basting with juices"
            ],
            cookingTime: 90,
            difficulty: "Medium",
            category: "Oven",
            imageName: "chicken_oven"
        ),
        Recipe(
            title: "Pan-Fried Chicken Breasts",
            ingredients: [
                "4 chicken breasts",
                "2 tbsp olive oil",
                "Salt, pepper to taste",
                "2 garlic cloves",
                "2 tbsp lemon juice",
                "Herbs for serving"
            ],
            steps: [
                "Pound chicken breasts to even thickness",
                "Rub with salt, pepper and garlic",
                "Heat pan with oil",
                "Fry breasts 6-7 minutes each side",
                "Add lemon juice at the end",
                "Serve with herbs"
            ],
            cookingTime: 20,
            difficulty: "Easy",
            category: "Pan",
            imageName: "chicken_breast"
        ),
        Recipe(
            title: "Chicken Noodle Soup",
            ingredients: [
                "500g chicken thighs",
                "200g noodles",
                "2 carrots",
                "1 onion",
                "2 garlic cloves",
                "Bay leaf",
                "Salt, pepper to taste",
                "Herbs for serving"
            ],
            steps: [
                "Make chicken broth from thighs",
                "Remove meat, separate from bones",
                "Add chopped vegetables to broth",
                "Cook for 15 minutes",
                "Add noodles and cook 10 more minutes",
                "Return meat to soup, season with salt and pepper"
            ],
            cookingTime: 60,
            difficulty: "Medium",
            category: "Soup",
            imageName: "chicken_soup"
        ),
        Recipe(
            title: "Caesar Salad with Chicken",
            ingredients: [
                "300g chicken breast",
                "1 head romaine lettuce",
                "100g parmesan cheese",
                "2 eggs",
                "White bread croutons",
                "2 garlic cloves",
                "4 anchovies",
                "100ml olive oil",
                "2 tbsp lemon juice"
            ],
            steps: [
                "Fry chicken breast and slice into strips",
                "Make dressing: mix eggs, garlic, anchovies, oil",
                "Cut lettuce into large pieces",
                "Mix lettuce with dressing",
                "Add chicken, parmesan and croutons",
                "Serve immediately"
            ],
            cookingTime: 30,
            difficulty: "Medium",
            category: "Salad",
            imageName: "caesar_salad"
        ),
        Recipe(
            title: "Honey Glazed Chicken Wings",
            ingredients: [
                "1 kg chicken wings",
                "3 tbsp honey",
                "2 tbsp soy sauce",
                "2 garlic cloves",
                "1 tsp ginger",
                "Salt, pepper to taste",
                "Sesame seeds for serving"
            ],
            steps: [
                "Preheat oven to 200°C",
                "Mix honey, soy sauce, garlic and ginger",
                "Season wings with salt and pepper",
                "Coat with sauce and marinate for 30 minutes",
                "Place on baking sheet and bake for 40 minutes",
                "Serve with sesame seeds"
            ],
            cookingTime: 70,
            difficulty: "Easy",
            category: "Oven",
            imageName: "chicken_wings"
        ),
        Recipe(
            title: "Chicken Nuggets",
            ingredients: [
                "500g chicken breast",
                "2 eggs",
                "100g breadcrumbs",
                "100g flour",
                "Salt, pepper to taste",
                "Oil for frying",
                "Sauce for serving"
            ],
            steps: [
                "Cut breast into 2-3 cm cubes",
                "Season with salt and pepper",
                "Coat in flour, then egg, then breadcrumbs",
                "Heat oil in pan",
                "Fry nuggets until golden brown",
                "Serve with sauce"
            ],
            cookingTime: 25,
            difficulty: "Easy",
            category: "Pan",
            imageName: "chicken_nuggets"
        ),
        Recipe(
            title: "Chicken Pilaf",
            ingredients: [
                "500g chicken thighs",
                "300g rice",
                "2 carrots",
                "1 onion",
                "3 garlic cloves",
                "Turmeric, cumin, barberries",
                "Salt to taste",
                "Vegetable oil"
            ],
            steps: [
                "Fry chicken until golden brown",
                "Add chopped onion and carrots",
                "Fry vegetables for 5 minutes",
                "Add washed rice and spices",
                "Pour hot water 2 cm above rice",
                "Simmer covered for 30 minutes"
            ],
            cookingTime: 50,
            difficulty: "Medium",
            category: "Pan",
            imageName: "chicken_pilaf"
        ),
        Recipe(
            title: "Chicken Curry",
            ingredients: [
                "600g chicken breast",
                "400ml coconut milk",
                "2 onions",
                "3 garlic cloves",
                "1 tsp ginger",
                "2 tsp curry powder",
                "1 tsp turmeric",
                "Salt to taste",
                "Rice for serving"
            ],
            steps: [
                "Cut chicken into cubes",
                "Fry onion, garlic and ginger",
                "Add spices and fry for 1 minute",
                "Add chicken and fry for 5 minutes",
                "Pour in coconut milk",
                "Simmer for 20 minutes, serve with rice"
            ],
            cookingTime: 40,
            difficulty: "Medium",
            category: "Pan",
            imageName: "chicken_curry"
        ),
        Recipe(
            title: "Chicken Avocado Salad",
            ingredients: [
                "300g chicken breast",
                "2 avocados",
                "200g cherry tomatoes",
                "1 cucumber",
                "100g feta cheese",
                "Olive oil",
                "Lemon juice",
                "Salt, pepper to taste"
            ],
            steps: [
                "Boil chicken breast and cut into cubes",
                "Cut avocado, tomatoes and cucumber",
                "Mix all ingredients",
                "Add feta cheese",
                "Dress with oil and lemon juice",
                "Season with salt and pepper and serve"
            ],
            cookingTime: 20,
            difficulty: "Easy",
            category: "Salad",
            imageName: "chicken_avocado_salad"
        ),
        Recipe(
            title: "Chicken Patties",
            ingredients: [
                "500g chicken mince",
                "1 egg",
                "1 onion",
                "2 garlic cloves",
                "100g bread",
                "Salt, pepper to taste",
                "Oil for frying"
            ],
            steps: [
                "Soak bread in milk",
                "Finely chop onion and garlic",
                "Mix mince with egg, onion, garlic",
                "Add soaked bread",
                "Season with salt and pepper and mix",
                "Form patties and fry"
            ],
            cookingTime: 35,
            difficulty: "Medium",
            category: "Pan",
            imageName: "chicken_patties"
        ),
        Recipe(
            title: "Chicken Broth",
            ingredients: [
                "1 whole chicken",
                "2 carrots",
                "2 onions",
                "2 garlic cloves",
                "Bay leaf",
                "Peppercorns",
                "Salt to taste",
                "Herbs"
            ],
            steps: [
                "Place chicken in large pot",
                "Add whole vegetables and spices",
                "Cover with cold water",
                "Bring to boil and skim foam",
                "Simmer on low heat for 2-3 hours",
                "Strain and season with salt"
            ],
            cookingTime: 180,
            difficulty: "Easy",
            category: "Soup",
            imageName: "chicken_broth"
        ),
        Recipe(
            title: "Chicken Thighs in Cream Sauce",
            ingredients: [
                "6 chicken thighs",
                "200ml cream",
                "2 garlic cloves",
                "1 onion",
                "100g mushrooms",
                "Salt, pepper to taste",
                "Oil for frying",
                "Herbs"
            ],
            steps: [
                "Fry thighs until golden brown",
                "Add onion and mushrooms",
                "Fry for 5 minutes",
                "Add garlic and cream",
                "Simmer for 20 minutes",
                "Season with salt and pepper and serve with herbs"
            ],
            cookingTime: 45,
            difficulty: "Medium",
            category: "Pan",
            imageName: "chicken_cream_sauce"
        )
    ]
}
