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
        self.recipeDetailsView?.startRecipeDetailsViewLoader()
        self.recipeDetailsInteractor?.getRecipeDetails(recipe: recipeDetails)
    }

    
}

extension RecipeDetailsPresenter: InteractorToPresenterRecipeDetailsProtocol {
    func sendRecipeDetailsToPresenter(recipeDetails: Hits) {
        self.recipeDetailsView?.endRecipeDetailsViewLoader()
        recipeDetailsView?.sendRecipeDetailsToView(recipeDetails: recipeDetails)
    }

    func sendDataFailed(error: String) {
        self.recipeDetailsView?.endRecipeDetailsViewLoader()
        self.recipeDetailsView?.sendErrorToView(error: error)
    }

}
