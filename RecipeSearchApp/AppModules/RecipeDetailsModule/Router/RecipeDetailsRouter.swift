//
//  RecipeDetailsRouter.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//

import Foundation

class RecipeDetailsRouter: PresenterToRouterRecipeDetailsProtocol {
    static func createModule(recipeDetailsViewController: RecipeDetailsViewController) -> RecipeDetailsViewController {
        let presenter = RecipeDetailsPresenter()
        
        recipeDetailsViewController.recipeDetailsPresenter = presenter
        
        recipeDetailsViewController.recipeDetailsPresenter?.recipeDetailsInteractor = RecipeDetailsInteractor()
        recipeDetailsViewController.recipeDetailsPresenter?.recipeDetailsView = recipeDetailsViewController
        
        recipeDetailsViewController.recipeDetailsPresenter?.recipeDetailsInteractor?.presenter = presenter
        
        return recipeDetailsViewController
    }
    
}
