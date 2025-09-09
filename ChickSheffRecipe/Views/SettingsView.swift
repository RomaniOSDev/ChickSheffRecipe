//
//  SettingsView.swift
//  ChickSheffRecipe
//
//  Created by Роман Главацкий on 09.09.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @State private var showingPrivacyPolicy = false
    @State private var showingAbout = false
    @StateObject private var favoritesManager = FavoritesManager()
    @StateObject private var userRecipeManager = UserRecipeManager()
    
    var body: some View {
        NavigationView {
            List {
                // Секция приложения
                Section("App") {
                    Button(action: {
                        showingAbout = true
                    }) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("About App")
                                    .foregroundColor(.primary)
                                Text("Version 1.0.0")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        rateApp()
                    }) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Rate App")
                                    .foregroundColor(.primary)
                                Text("Help us improve")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                
                // Секция правовых документов
                Section("Legal Information") {
                    Button(action: {
                        if let url = URL(string: "https://Privacy") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "hand.raised.fill")
                                .foregroundColor(.orange)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Privacy Policy")
                                    .foregroundColor(.primary)
                                Text("How we use your data")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        if let url = URL(string: "https://Terms") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                                .foregroundColor(.indigo)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Terms of Service")
                                    .foregroundColor(.primary)
                                Text("App usage rules")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // Секция статистики
                Section("Statistics") {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Favorite Recipes")
                                .foregroundColor(.primary)
                            Text("Your favorite dishes")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("\(favoritesManager.favoriteRecipeIds.count)")
                            .font(.headline)
                            .foregroundColor(Color("WarmRed"))
                    }
                    
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 24)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Created Recipes")
                                .foregroundColor(.primary)
                            Text("Your own recipes")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("\(userRecipeManager.userRecipes.count)")
                            .font(.headline)
                            .foregroundColor(Color("WarmRed"))
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingPrivacyPolicy) {
            PrivacyPolicyView()
        }
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
    }
    
    // MARK: - Actions
    
    private func rateApp() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    private func shareApp() {
        let activityViewController = UIActivityViewController(
            activityItems: [
                "Попробуйте приложение 'Куриный Шеф' - лучшая кулинарная книга рецептов из курицы! 🐔👨‍🍳"
            ],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityViewController, animated: true)
        }
    }
    
    private func sendFeedback() {
        if let url = URL(string: "mailto:support@chickenshef.app?subject=Отзыв о приложении Куриный Шеф") {
            UIApplication.shared.open(url)
        }
    }
    
    private func openTermsOfService() {
        if let url = URL(string: "https://chickenshef.app/terms") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Privacy Policy View
struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Privacy Policy")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("1. Data Collection")
                            .font(.headline)
                            .foregroundColor(Color("Orange"))
                        
                        Text("The 'Chicken Chef' app collects minimal information necessary for operation:")
                        Text("• Favorite recipes (stored locally on device)")
                        Text("• User-created recipes (stored locally on device)")
                        Text("• App settings (stored locally on device)")
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("2. Data Usage")
                            .font(.headline)
                            .foregroundColor(Color("Orange"))
                        
                        Text("We use your data only for:")
                        Text("• Saving your favorite recipes")
                        Text("• Storing your created recipes")
                        Text("• Improving app performance")
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("3. Data Protection")
                            .font(.headline)
                            .foregroundColor(Color("Orange"))
                        
                        Text("• All data is stored locally on your device")
                        Text("• We do not share your data with third parties")
                        Text("• We do not collect personal information")
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("4. Contact")
                            .font(.headline)
                            .foregroundColor(Color("Orange"))
                        
                        Text("If you have questions about the privacy policy, contact us:")
                        Text("Email: privacy@chickenshef.app")
                    }
                    
                    Text("Last updated: September 9, 2025")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top)
                }
                .padding()
            }
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - About View
struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Логотип приложения
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("WarmRed"), Color("Red"), Color("Yellow")]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                        
                        Image(systemName: "bird.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                    }
                    
                    Text("Chicken Chef")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Version 1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Описание приложения
                VStack(alignment: .leading, spacing: 16) {
                    Text("About App")
                        .font(.headline)
                        .foregroundColor(Color("Orange"))
                    
                    Text("Chicken Chef is your personal cookbook dedicated to chicken recipes. Discover many delicious and healthy dishes, create your own recipes and share them with friends.")
                        .font(.body)
                        .lineSpacing(4)
                }
                .padding(.horizontal)
                
                // Особенности
                VStack(alignment: .leading, spacing: 12) {
                    Text("Features")
                        .font(.headline)
                        .foregroundColor(Color("Orange"))
                    
                    FeatureRow(icon: "heart.fill", text: "Favorite recipes")
                    FeatureRow(icon: "plus.circle.fill", text: "Create custom recipes")
                    FeatureRow(icon: "timer", text: "Cooking timer")
                    FeatureRow(icon: "magnifyingglass", text: "Search and filter")
                    FeatureRow(icon: "star.fill", text: "Beautiful interface")
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Копирайт
                Text("© 2025 Chicken Chef. All rights reserved.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .navigationTitle("About App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color("WarmRed"))
                .frame(width: 20)
            
            Text(text)
                .font(.body)
            
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
}
