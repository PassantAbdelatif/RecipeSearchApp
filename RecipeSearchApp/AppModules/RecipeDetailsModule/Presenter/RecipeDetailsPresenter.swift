//
//  RecipeDetailsPresenter.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//

import Foundation
class RecipeDetailsPresenter: ViewToPresenterRecipeDetailsProtocol {
  
    
    var recipeDetailsInteractor: PresenterToInteractorRecipeDetailsProtocol?
    
    var recipeDetailsView: PresenterToViewRecipeDetailsProtocol?
    
    var recipeDetails: Hits?
    
    func getRecipesDetails() {
        recipeDetailsView?.startRecipeDetailsViewLoader()
        recipeDetailsInteractor?.getRecipeDetails(recipe: recipeDetails)
    }
    
    func shareRecipeUrl() {
        recipeDetailsInteractor?.shareRecipeUrl(recipe: recipeDetails)
    }
    
    func openRecipeWebsiteOnSafari() {
        recipeDetailsInteractor?.openRecipeWebsiteOnSafari(recipe: recipeDetails)
    }
}

extension RecipeDetailsPresenter: InteractorToPresenterRecipeDetailsProtocol {
    func sendRecipeDetailsToPresenter(recipeDetails: Hits) {
        recipeDetailsView?.endRecipeDetailsViewLoader()
        recipeDetailsView?.sendRecipeDetailsToView(recipeDetails: recipeDetails)
    }

    func sendDataFailed(error: String) {
        recipeDetailsView?.endRecipeDetailsViewLoader()
        recipeDetailsView?.sendErrorToView(error: error)
    }

}
