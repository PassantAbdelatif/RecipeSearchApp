//
//  RecipeSearchRouter.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import UIKit

class RecipeSearchRouter: PresenterToRouterRecipesProtocol {
 
    static func createModule(recipeSearchViewController: RecipeSearchViewController) {
        let presenter = RecipeSearchPresenter()
        
        recipeSearchViewController.recipeSearchPresenter = presenter
        
        recipeSearchViewController.recipeSearchPresenter?.recipesSearchInteractor = RecipeSearchInteractor()
        recipeSearchViewController.recipeSearchPresenter?.recipesSearchView = recipeSearchViewController 
        
        recipeSearchViewController.recipeSearchPresenter?.recipesSearchInteractor?.presenter = presenter
    }
    
    static func pushToRecipeDetialsScreen(recipe: Hits,
                                          navigationConroller navigationController: UINavigationController) {
        let recipeDetailsModuel = RecipeDetailsRouter.createModule(recipeDetailsViewController: RecipeDetailsViewController())
        recipeDetailsModuel.recipeDetailsPresenter?.recipeDetails = recipe
        navigationController.pushViewController(recipeDetailsModuel,
                                                animated: true)
    }
}
