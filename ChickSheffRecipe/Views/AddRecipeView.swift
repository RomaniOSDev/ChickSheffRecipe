//
//  AddRecipeView.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    private let dataService: MockDataService
    
    @State private var title = ""
    @State private var ingredients: [String] = [""]
    @State private var steps: [String] = [""]
    @State private var cookingTime = 30
    @State private var difficulty = "Easy"
    @State private var category = "Pan"
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let categories = ["Oven", "Pan", "Soup", "Salad"]
    
    init(dataService: MockDataService) {
        self.dataService = dataService
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Basic Information") {
                    TextField("Recipe title", text: $title)
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    
                    Picker("Difficulty", selection: $difficulty) {
                        ForEach(difficulties, id: \.self) { difficulty in
                            Text(difficulty).tag(difficulty)
                        }
                    }
                    
                    HStack {
                        Text("Cooking time")
                        Spacer()
                        Stepper("\(cookingTime) min", value: $cookingTime, in: 5...300, step: 5)
                    }
                }
                
                Section("Ingredients") {
                    ForEach(ingredients.indices, id: \.self) { index in
                        HStack {
                            TextField("Ingredient \(index + 1)", text: $ingredients[index])
                            
                            if ingredients.count > 1 {
                                Button(action: {
                                    ingredients.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        ingredients.append("")
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add ingredient")
                        }
                        .foregroundColor(Color("WarmRed"))
                    }
                }
                
                Section("Step-by-step Instructions") {
                    ForEach(steps.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Step \(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(Color("WarmRed"))
                                
                                Spacer()
                                
                                if steps.count > 1 {
                                    Button(action: {
                                        steps.remove(at: index)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            
                            TextField("Describe the cooking step", text: $steps[index], axis: .vertical)
                                .lineLimit(3...6)
                        }
                    }
                    
                    Button(action: {
                        steps.append("")
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add step")
                        }
                        .foregroundColor(Color("WarmRed"))
                    }
                }
            }
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .alert("Recipe saved!", isPresented: $showingAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var isFormValid: Bool {
        !title.isEmpty &&
        !ingredients.allSatisfy { $0.isEmpty } &&
        !steps.allSatisfy { $0.isEmpty }
    }
    
    private func saveRecipe() {
        let filteredIngredients = ingredients.filter { !$0.isEmpty }
        let filteredSteps = steps.filter { !$0.isEmpty }
        
        let userRecipe = UserRecipe(
            title: title,
            ingredients: filteredIngredients,
            steps: filteredSteps,
            cookingTime: cookingTime,
            difficulty: difficulty,
            category: category
        )
        
        dataService.addUserRecipe(userRecipe)
        alertMessage = "Recipe '\(title)' successfully added!"
        showingAlert = true
    }
}

#Preview {
    AddRecipeView(dataService: MockDataService())
}
