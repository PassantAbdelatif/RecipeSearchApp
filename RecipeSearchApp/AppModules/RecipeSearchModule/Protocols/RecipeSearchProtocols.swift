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
    
    func getRecipesSearchResult(searchString: String,
                                healthFilter: String?,
                                nextUrl: String?)
}

protocol PresenterToInteractorRecipesProtocol {
    var presenter: InteractorToPresenterRecipesProtocol? {get set}
    func getRecipesSearchResult(searchString: String,
                                healthFilter: String?,
                                nextUrl: String?)
}

protocol InteractorToPresenterRecipesProtocol {
    func sendDataToPresenter(recipeList: [Hits], hasNextPage: Bool, nextUrl: String?)
    func sendDataFailed(error: String)
}

protocol PresenterToViewRecipesProtocol {
    func startViewLoader()
    func endViewLoader()
    func sendDataToView(recipeList: [Hits], hasNextPage: Bool, nextUrl: String?)
    func sendErrorToView(error: String)
}

protocol PresenterToRouterRecipesProtocol {
    static func createModule(ref: RecipeSearchVC)
}
