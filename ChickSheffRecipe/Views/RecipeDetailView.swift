//
//  RecipeDetailView.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var viewModel: RecipeDetailViewModel
    @StateObject private var timerManager = TimerManager()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Заголовок и основная информация
                VStack(spacing: 12) {
                    // Изображение рецепта
                    RecipeImageView(imageName: viewModel.recipe.imageName, size: CGSize(width: 300, height: 150))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    
                    // Название и метаданные
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.recipe.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        HStack(spacing: 16) {
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(Color("Orange"))
                                Text(viewModel.getCookingTimeText())
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Image(systemName: "chart.bar.fill")
                                    .foregroundColor(Color("Orange"))
                                Text(viewModel.recipe.difficulty)
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                            
                            Text(viewModel.recipe.category)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color("Orange"))
                                )
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
                
                // Таймер приготовления
                VStack(alignment: .leading, spacing: 12) {
                    Text("Cooking Timer")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    VStack(spacing: 16) {
                        // Прогресс-бар
                        VStack(spacing: 8) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(timerManager.timerName.isEmpty ? "Cooking \(viewModel.recipe.title)" : timerManager.timerName)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    if timerManager.isRunning {
                                        HStack {
                                            Circle()
                                                .fill(Color.green)
                                                .frame(width: 8, height: 8)
                                            Text("Cooking in progress")
                                                .font(.caption)
                                                .foregroundColor(.green)
                                        }
                                    } else if timerManager.isPaused {
                                        HStack {
                                            Circle()
                                                .fill(Color.orange)
                                                .frame(width: 8, height: 8)
                                            Text("Paused")
                                                .font(.caption)
                                                .foregroundColor(.orange)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                Text(timerManager.formattedTime)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(timerManager.isRunning ? Color("Orange") : .secondary)
                            }
                            
                            ProgressView(value: timerManager.progress)
                                .progressViewStyle(LinearProgressViewStyle(tint: timerManager.isRunning ? Color("Orange") : .gray))
                                .scaleEffect(x: 1, y: 2, anchor: .center)
                        }
                        
                        // Кнопки управления таймером
                        HStack(spacing: 12) {
                            if !timerManager.isRunning && timerManager.timeRemaining == 0 {
                                Button(action: {
                                    timerManager.startTimer(
                                        duration: TimeInterval(viewModel.recipe.cookingTime * 60),
                                        name: viewModel.recipe.title
                                    )
                                }) {
                                    HStack {
                                        Image(systemName: "play.fill")
                                        Text("Start Timer")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("Orange"))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            } else {
                                if timerManager.isRunning {
                                    Button(action: {
                                        timerManager.pauseTimer()
                                    }) {
                                        HStack {
                                            Image(systemName: "pause.fill")
                                            Text("Pause")
                                        }
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.orange)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                } else if timerManager.isPaused {
                                    Button(action: {
                                        timerManager.resumeTimer()
                                    }) {
                                        HStack {
                                            Image(systemName: "play.fill")
                                            Text("Resume")
                                        }
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.green)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                                
                                Button(action: {
                                    timerManager.stopTimer()
                                }) {
                                    HStack {
                                        Image(systemName: "stop.fill")
                                        Text("Stop")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
                
                // Ингредиенты
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(Array(viewModel.recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(index + 1).")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Orange"))
                                    .frame(width: 20, alignment: .leading)
                                
                                Text(ingredient)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
                
                // Пошаговая инструкция
                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(viewModel.recipe.steps.enumerated()), id: \.offset) { index, step in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 28, height: 28)
                                    .background(
                                        Circle()
                                            .fill(Color("Orange"))
                                    )
                                
                                Text(step)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                }
                
                // Кнопка "Приготовил!"
                Button(action: {
                    viewModel.markAsCooked()
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Cooked!")
                            .fontWeight(.semibold)
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("Orange"), Color("Orange").opacity(0.8)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
        .alert("Congratulations! 🎉", isPresented: $viewModel.showCookingCompleteAlert) {
            Button("Great!") { }
        } message: {
            Text("You successfully cooked \(viewModel.recipe.title)!")
        }
        .alert("Timer completed! ⏰", isPresented: $timerManager.showCompletionAlert) {
            Button("OK") { }
        } message: {
            Text("Cooking time for '\(timerManager.timerName)' has expired!")
        }
    }
}

#Preview {
    NavigationView {
        RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: Recipe.sampleRecipes[0]))
    }
}
