//
//  RecipeSearchPresenter.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation
class RecipeSearchPresenter: ViewToPresenterRecipesProtocol {
    
    var recipesSearchInteractor: PresenterToInteractorRecipesProtocol?
    var recipesSearchView: PresenterToViewRecipesProtocol?
    
    func getRecipesSearchResult(searchString: String, healthFilter: String?, nextUrl: String?) {
        self.recipesSearchView?.startViewLoader()
        recipesSearchInteractor?.getRecipesSearchResult(searchString: searchString,
                                                        healthFilter: healthFilter,
                                                        nextUrl: nextUrl)
    }
}

extension RecipeSearchPresenter: InteractorToPresenterRecipesProtocol {
    func sendDataToPresenter(recipeList: [Hits], hasNextPage: Bool, nextUrl: String?) {
        self.recipesSearchView?.endViewLoader()
        self.recipesSearchView?.sendDataToView(recipeList: recipeList, hasNextPage: hasNextPage, nextUrl: nextUrl)
    }

    func sendDataFailed(error: String) {
        self.recipesSearchView?.endViewLoader()
        self.recipesSearchView?.sendErrorToView(error: error)
    }

}
