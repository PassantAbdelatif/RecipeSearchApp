//
//  Links.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Links: Codable {

  enum CodingKeys: String, CodingKey {
    case next
  }

  var next: Next?
}

class RecipeLinks: Codable {

  enum CodingKeys: String, CodingKey {
    case recipeLinks  = "self"
  }

  var recipeLinks: Next?
}
