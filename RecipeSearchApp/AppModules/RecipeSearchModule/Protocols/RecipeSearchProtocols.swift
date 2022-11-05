//
//  RecipeSearchProtocols.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 03/11/2022.
//

import Foundation

protocol ViewToPresenterRecipesProtocol {
    var recipesSearchInteractor: PresenterToInteractorRecipesProtocol? {get set}
    var recipesSearchView: PresenterToViewRecipesProtocol? {get set}
    
    var selectedHealthFilter: String? {get set}
    var nextUrl: String? {get set}
    var hasNext: Bool? {get set}
    var searchString: String? {get set}
    
    func getRecipesSearchResult(updateListStatus: UpdateListStatus)
    func getRecipeHealthCategories()
    func saveSearchString()
    func getSavedSearchStrings()
}

protocol PresenterToInteractorRecipesProtocol {
    var presenter: InteractorToPresenterRecipesProtocol? {get set}
    func getRecipesSearchResult(searchString: String,
                                healthFilter: String?,
                                nextUrl: String?)
    func getRecipeHealthCategories()
    func saveSearchString(searchString: String)
    func getSavedSearchStrings()
}

protocol InteractorToPresenterRecipesProtocol {
    func sendDataToPresenter(recipeList: [Hits], hasNextPage: Bool, nextUrl: String?)
    func sendDataFailed(error: String)
    func sendHealthCategoriesDataToPresenter(healthLabels: [String])
    func sendSavedSearchStringsToPresenter(savedSearchStrings: [String])
}

protocol PresenterToViewRecipesProtocol {
    func startViewLoader()
    func endViewLoader()
    func sendDataToView(recipeList: [Hits])
    func sendErrorToView(error: String)
    func sendHealthCategoriesDataToView(healthLabels: [String])
    func sendSavedSearchStringsToView(savedSearchStrings: [String])
}

protocol PresenterToRouterRecipesProtocol {
    static func createModule(ref: RecipeSearchViewController)
}
