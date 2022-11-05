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
    
    var selectedHealthFilter: String?
    var nextUrl: String?
    var hasNext: Bool?
    var searchString: String?
    
    func getRecipesSearchResult(updateListStatus: UpdateListStatus) {
        switch updateListStatus {
        case .refresh:
            
            self.recipesSearchView?.startViewLoader()
            recipesSearchInteractor?.getRecipesSearchResult(searchString: searchString ?? "",
                                                            healthFilter: selectedHealthFilter,
                                                            nextUrl: nil)
        case .loadMore:
            recipesSearchInteractor?.getRecipesSearchResult(searchString: searchString ?? "",
                                                            healthFilter: selectedHealthFilter,
                                                            nextUrl: nextUrl)
        }
        
    }
    
    func getRecipeHealthCategories() {
        recipesSearchInteractor?.getRecipeHealthCategories()
    }
    
    func saveSearchString() {
        self.recipesSearchInteractor?.saveSearchString(searchString: self.searchString ?? "")
    }
    
    func getSavedSearchStrings() {
        self.recipesSearchInteractor?.getSavedSearchStrings()
    }
    
}

extension RecipeSearchPresenter: InteractorToPresenterRecipesProtocol {
   
    
    func sendDataToPresenter(recipeList: [Hits],
                             hasNextPage: Bool,
                             nextUrl: String?) {
        self.hasNext = hasNextPage
        self.nextUrl = nextUrl
        self.recipesSearchView?.endViewLoader()
        self.recipesSearchView?.sendDataToView(recipeList: recipeList)
    }

    func sendDataFailed(error: String) {
        self.recipesSearchView?.endViewLoader()
        self.recipesSearchView?.sendErrorToView(error: error)
    }

    func sendHealthCategoriesDataToPresenter(healthLabels: [String]) {
        self.recipesSearchView?.sendHealthCategoriesDataToView(healthLabels: healthLabels)
    }
    
    func sendSavedSearchStringsToPresenter(savedSearchStrings: [String]) {
        self.recipesSearchView?.sendSavedSearchStringsToView(savedSearchStrings: savedSearchStrings)
    }
}
