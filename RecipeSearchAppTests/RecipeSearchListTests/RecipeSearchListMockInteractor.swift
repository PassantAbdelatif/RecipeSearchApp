//
//  RecipeSearchInteractorMock.swift
//  RecipeSearchAppTests
//
//  Created by Passant Abdelatif on 06/11/2022.
//

import XCTest
@testable import RecipeSearchApp
class RecipeSearchListMockInteractor: PresenterToInteractorRecipesProtocol {
    var presenter: InteractorToPresenterRecipesProtocol?
    
     var fetchRecipeListSearchCalled = false
     var recipes: [Hits]
    
      init(recipes: [Hits] = []) {
          self.recipes = recipes
      }
    
     func getRecipesSearchResult(searchString: String,
                                healthFilter: String?,
                                nextUrl: String?) {
        fetchRecipeListSearchCalled = true
        let mockedHits = Hits()
         
        presenter?.sendDataToPresenter(recipeList: [mockedHits],
                                       hasNextPage: false,
                                       nextUrl: nil)
    }
    var fetchHealthCategoriesCalled = false
    var healthLabels: [String]
    func getRecipeHealthCategories() {
        fetchHealthCategoriesCalled = true
        presenter?.sendHealthCategoriesDataToPresenter(healthLabels: <#T##[String]#>)
    }
    
    func saveSearchString(searchString: String) {
        
    }
    
    func getSavedSearchStrings() {
        
    }
    
    
}
