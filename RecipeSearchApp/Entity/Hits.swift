//
//  Hits.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Hits: Codable {

  enum CodingKeys: String, CodingKey {
    case links = "_links"
    case recipe
  }

  var links: RecipeLinks?
  var recipe: Recipe?


}
