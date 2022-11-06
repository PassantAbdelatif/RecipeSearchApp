//
//  RecipeSearchInteractor.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation
class RecipeSearchInteractor: PresenterToInteractorRecipesProtocol {

    var presenter: InteractorToPresenterRecipesProtocol?
    
    
    func getRecipesSearchResult(searchString: String,
                                healthFilter: String?,
                                nextUrl: String?) {
        
        var  params : [String : Any] = ["q": searchString,
                                        "app_key": Configuration.appKey,
                                        "app_id" : Configuration.appId,
                                        "type"   : "public"]
        if let healthFilter = healthFilter {
             params["health"] = healthFilter
        }
        var requestUrl = "\(Configuration.baseURL)\(Configuration.API_RECIPE_SEARCH_LIST)"
        if let nextUrl = nextUrl {
            requestUrl = nextUrl
        }
        
        NetworkCall(data: params,
                    url: requestUrl,
                    service: nil,
                    method: .get,
                    isJSONRequest: false).executeQuery(){
            (result: Result<RecipeSearchResponse,Error>) in
            switch result{
            case .success(let result):
                var hasNextPage = false
                if let count = result.count,
                   let toValue = result.to {
                    if toValue < count {
                        hasNextPage = true
                    }
                }
                if let list = result.hits {
                    
                    self.presenter?.sendDataToPresenter(recipeList: list,
                                                        hasNextPage: hasNextPage,
                                                        nextUrl: result.links?.next?.href)
                    
                }
            case .failure(let error):
                if let networkError = error as? NetworkError {
                    self.presenter?.sendDataFailed(error: networkError.message ?? networkError.error ?? "")
                } else {
                    self.presenter?.sendDataFailed(error: error.localizedDescription)
                }
                
            }
        }
    }
    
    func getRecipeHealthCategories() {
        let healthLabels = ["All",
                            "sugar-conscious",
                            "low-potassium",
                            "low-fat-abs",
                            "low-sugar",
                            "kidney-friendly",
                            "vegetarian",
                            "pescatarian",
                            "Mediterranean",
                            "dairy-free",
                            "DASH",
                            "egg-free",
                            "peanut-free",
                            "tree-nut-free",
                            "soy-free",
                            "fish-free",
                            "shellfish-free",
                            "fodmap-free",
                            "pork-free",
                            "red-meat-free",
                            "crustacean-free",
                            "celery-free",
                            "mustard-free",
                            "gluten-free",
                            "sesame-free",
                            "lupine-free",
                            "mollusk-free",
                            "alcohol-free",
                            "alcohol-cocktail",
                            "no-oil-added",
                            "sulfite-free",
                            "immuno-supportive",
                            "keto-friendly",
                            "pescatarian",
                            "paleo",
                            "kosher",
                            "wheat-free"]
        self.presenter?.sendHealthCategoriesDataToPresenter(healthLabels: healthLabels)
    }
    
    func saveSearchString(searchString: String) {
        let userDefaults = UserDefaults.standard

        var searchStrings: [String] = userDefaults.object(forKey: UserDefaultsKeys.searchKeys.rawValue) as? [String] ?? []
        
        searchStrings.append(searchString)
     
        userDefaults.set(searchStrings, forKey: UserDefaultsKeys.searchKeys.rawValue)
    }
    
    func getSavedSearchStrings() {
        let userDefaults = UserDefaults.standard
        let searchStrings: [String] = userDefaults.object(forKey: UserDefaultsKeys.searchKeys.rawValue) as? [String] ?? []
        self.presenter?.sendSavedSearchStringsToPresenter(savedSearchStrings: searchStrings)
    }
}

