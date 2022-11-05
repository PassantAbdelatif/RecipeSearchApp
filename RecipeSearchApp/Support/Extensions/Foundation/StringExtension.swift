//
//  StringExtension.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 04/11/2022.
//

import Foundation

extension String {
    func toURLString(_ baseUrl: String = Configuration.baseURL) -> String? {
        
        if self.isEmpty {
            return nil
        }
        return self
    }
    
    var isSearchStringContainsEnglishCharactersAndSpaces: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", ".*[^A-Za-z ].*")
        return predicate.evaluate(with: self)
    }
   
}
