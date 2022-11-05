//
//  Configuration.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 02/11/2022.
//

import Foundation

public enum Configuration {
    
    static var baseURL: String = "https://api.edamam.com"
        
    static let appId = "451d3332"
    static let appKey = "4b2a0ddb33dc731ca2d84107bbb45a63"
    
    static let API_RECIPE_SEARCH_LIST = "/api/recipes/v2"
    static let API_RECIPE_DETAILS = "/api/recipes/v2/"
}

enum UserDefaultsKeys: String {
    case searchKeys = "searchKeys"
}
