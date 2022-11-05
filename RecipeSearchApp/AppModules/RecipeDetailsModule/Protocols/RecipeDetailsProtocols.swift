//
//  RecipeDetailsProtocols.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//

import Foundation

protocol ViewToPresenterRecipeDetailsProtocol {
    var recipeDetailsInteractor: PresenterToInteractorRecipeDetailsProtocol? {get set}
    var recipeDetailsView: PresenterToViewRecipeDetailsProtocol? {get set}
    
    var recipeDetails: Hits? {get set}
    func getRecipesDetails()
}

protocol PresenterToInteractorRecipeDetailsProtocol {
    var presenter: InteractorToPresenterRecipeDetailsProtocol? {get set}
    func getRecipeDetails(recipe: Hits?)
}

protocol InteractorToPresenterRecipeDetailsProtocol {
    func sendRecipeDetailsToPresenter(recipeDetails: Hits)
    func sendDataFailed(error: String)
}

protocol PresenterToViewRecipeDetailsProtocol {
    func startRecipeDetailsViewLoader()
    func endRecipeDetailsViewLoader()
    func sendRecipeDetailsToView(recipeDetails: Hits)
    func sendErrorToView(error: String)
}

protocol PresenterToRouterRecipeDetailsProtocol {
    static func createModule(recipeDetailsViewController: RecipeDetailsViewController) -> RecipeDetailsViewController
}
