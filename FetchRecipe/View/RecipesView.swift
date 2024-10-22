//
//  ContentView.swift
//  FetchRecipe
//
//  Created by Brad Slayter on 10/22/24.
//

import SwiftUI

/// Main app view
/// This view contains the list of recipes and communicates with the ViewModel
struct RecipesView: View {

    @ObservedObject var viewModel: RecipesViewModel
    @State var showDebugMenu: Bool = false // For overriding API endpoints

    func loadRecipes() async {
        await viewModel.fetchRecipes()
    }

    var listView: some View {
        LazyVStack {
            ForEach(viewModel.recipes) { recipe in
                RecipeView(recipe: recipe)
            }
        }
    }

    var body: some View {
        ZStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if viewModel.error != nil {
                        // Error state
                        VStack {
                            Text("An error occured while loading recipes.")
                            Text("Pull to refresh to try again.")
                        }
                    } else if !viewModel.recipes.isEmpty {
                        // Default state with data
                        listView
                    } else {
                        // Empty state
                        Text("No recipes found. Come back later! 🍳")
                    }
                }
            }
            .refreshable { // Enables pull to refresh
                await loadRecipes()
            }

            // Floating Action Button - for debug menu
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    Button {
                        showDebugMenu = true
                    } label: {
                        Image(systemName: "ladybug.slash")
                            .renderingMode(.template)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                }
                .padding()
            }
        }
        .padding([.horizontal, .bottom])
        .ignoresSafeArea(.container, edges: [.bottom])
        .navigationTitle("Recipes")
        .onAppear {
            // Load recipes on app start
            Task {
                await loadRecipes()
            }
        }
        .alert("Change API Endpoint", isPresented: $showDebugMenu, actions: {
            // Debug menu
            Button("Default") {
                viewModel.changeApiEndpoint(to: .api)
            }
            Button("Malformed Data") {
                viewModel.changeApiEndpoint(to: .malformedApi)
            }
            Button("Empty Data") {
                viewModel.changeApiEndpoint(to: .emptyApi)
            }
            Button("Cancel", role: .cancel) { }
        }, message: {
            Text("Select an option to change the API endpoint.")
        })
    }
}

#Preview {
    NavigationStack {
        RecipesView(
            viewModel: RecipesViewModel(recipesApi: PreviewRecipeAPI())
        )
    }
}
