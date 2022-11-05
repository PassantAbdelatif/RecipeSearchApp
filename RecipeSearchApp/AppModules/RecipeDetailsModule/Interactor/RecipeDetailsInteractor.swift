//
//  RecipeDetailsInteractor.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 05/11/2022.
//

import Foundation
class RecipeDetailsInteractor: PresenterToInteractorRecipeDetailsProtocol {
 
    var presenter: InteractorToPresenterRecipeDetailsProtocol?
    
    func getRecipeDetails(recipe: Hits?) {
        if let recipe = recipe,
           let recipeDetailsUrl = recipe.links?.recipeLinks?.href {
            let  params : [String : Any] = ["app_key": Configuration.appKey,
                                            "app_id" : Configuration.appId,
                                            "type"   : "public"]
            NetworkCall(data: params,
                        url: recipeDetailsUrl,
                        service: nil,
                        method: .get,
                        isJSONRequest: false).executeQuery(){
                (result: Result<Hits,Error>) in
                switch result{
                case .success(let result):
                    self.presenter?.sendRecipeDetailsToPresenter(recipeDetails: result)
                    
                case .failure(let error):
                    self.presenter?.sendDataFailed(error: error.localizedDescription)
                }
            }
        } else {
            self.presenter?.sendDataFailed(error: "couldn't get recipe details")
        }
    }
    
}

