//
//  RecipeSearchInteractor.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation
import Alamofire
class RecipeSearchInteractor: PresenterToInteractorRecipesProtocol {
    var presenter: InteractorToPresenterRecipesProtocol?
    
    
    func getRecipesSearchResult(searchString: String, healthFilter: String?, nextUrl: String?) {
        
        var  params: Parameters = ["q": searchString,
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
        Alamofire.request(requestUrl,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.queryString).response { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(RecipeSearchResponse.self,
                                                          from: data)
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
                } catch {
                    self.presenter?.sendDataFailed(error: error.localizedDescription)
                }
            }
        }
    }
    
    
}

