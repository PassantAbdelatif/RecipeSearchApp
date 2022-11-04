//
//  RecipeSearchRouter.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation

class RecipeSearchRouter: PresenterToRouterRecipesProtocol {
    static func createModule(ref: RecipeSearchVC) {
        let presenter = RecipeSearchPresenter()
        
        ref.recipeSearchPresenter = presenter
        
        ref.recipeSearchPresenter?.recipesSearchInteractor = RecipeSearchInteractor()
        ref.recipeSearchPresenter?.recipesSearchView = ref 
        
        ref.recipeSearchPresenter?.recipesSearchInteractor?.presenter = presenter
    }
    
}
