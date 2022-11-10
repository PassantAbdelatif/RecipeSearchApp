//
//  RecipeSearchSpy.swift
//  RecipeSearchAppTests
//
//  Created by Passant Abdelatif on 06/11/2022.
//

import XCTest
@testable import RecipeSearchApp

class RecipeSearchSpy: PresenterToInteractorRecipesProtocol {

    var invokedPresenterSetter = false
    var invokedPresenterSetterCount = 0
    var invokedPresenter: InteractorToPresenterRecipesProtocol?
    var invokedPresenterList = [InteractorToPresenterRecipesProtocol?]()
    var invokedPresenterGetter = false
    var invokedPresenterGetterCount = 0
    var stubbedPresenter: InteractorToPresenterRecipesProtocol!

    var presenter: InteractorToPresenterRecipesProtocol? {
        set {
            invokedPresenterSetter = true
            invokedPresenterSetterCount += 1
            invokedPresenter = newValue
            invokedPresenterList.append(newValue)
        }
        get {
            invokedPresenterGetter = true
            invokedPresenterGetterCount += 1
            return stubbedPresenter
        }
    }

    var invokedGetRecipesSearchResult = false
    var invokedGetRecipesSearchResultCount = 0
    var invokedGetRecipesSearchResultParameters: (searchString: String, healthFilter: String?, nextUrl: String?)?
    var invokedGetRecipesSearchResultParametersList = [(searchString: String, healthFilter: String?, nextUrl: String?)]()

    func getRecipesSearchResult(searchString: String,
        healthFilter: String?,
        nextUrl: String?) {
        invokedGetRecipesSearchResult = true
        invokedGetRecipesSearchResultCount += 1
        invokedGetRecipesSearchResultParameters = (searchString, healthFilter, nextUrl)
        invokedGetRecipesSearchResultParametersList.append((searchString, healthFilter, nextUrl))
    }

    var invokedGetRecipeHealthCategories = false
    var invokedGetRecipeHealthCategoriesCount = 0

    func getRecipeHealthCategories() {
        invokedGetRecipeHealthCategories = true
        invokedGetRecipeHealthCategoriesCount += 1
    }

    var invokedSaveSearchString = false
    var invokedSaveSearchStringCount = 0
    var invokedSaveSearchStringParameters: (searchString: String, Void)?
    var invokedSaveSearchStringParametersList = [(searchString: String, Void)]()

    func saveSearchString(searchString: String) {
        invokedSaveSearchString = true
        invokedSaveSearchStringCount += 1
        invokedSaveSearchStringParameters = (searchString, ())
        invokedSaveSearchStringParametersList.append((searchString, ()))
    }

    var invokedGetSavedSearchStrings = false
    var invokedGetSavedSearchStringsCount = 0

    func getSavedSearchStrings() {
        invokedGetSavedSearchStrings = true
        invokedGetSavedSearchStringsCount += 1
    }
}
