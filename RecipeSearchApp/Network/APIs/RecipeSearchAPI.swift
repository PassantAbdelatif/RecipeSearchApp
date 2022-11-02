//
//  RecipeSearchAPI.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 02/11/2022.
//

import Foundation
import Moya


enum  RecipeSearchAPI {

    case getRecipeSearchResult(q: String, health: String?)
    case getRecipeDetails(recipeId: Int)
 
}

extension RecipeSearchAPI: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        return URL(string: Configuration.baseURL)!
    }

    var path: String {
        switch self {
        case .getRecipeSearchResult:
            return "/api/recipes/v2"

        case .getRecipeDetails(let id):
            return "/api/recipes/v2/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getRecipeSearchResult:
            return .get

        case .getRecipeDetails:
            return .get

        }
    }



    var task: Task {
        switch self {
        case .getRecipeSearchResult:
            return .requestPlain

        case .getRecipeDetails:
            return .requestPlain

    

        }
    }
    var headers: [String: String]? {
        
        var header = [String: String]()
        
        header["content-type"] = "application/json"
        
        return header
    }

}
