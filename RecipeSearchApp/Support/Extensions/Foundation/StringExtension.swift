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
    
    var isStringContainsEnglishCharactersAndSpaces: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", ".*[^A-Za-z ].*")
        return predicate.evaluate(with: self)
    }
    
    func validateIsStringStartWithWhiteSpaces(range: NSRange)  -> Bool {
        let newString = (self as NSString).replacingCharacters(in: range,
                                                                          with: self) as NSString
        
        return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
    }
    
    
}

extension NSString {

   var isStartWithWhitespace: Bool {
   
    return  self.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
}
}
