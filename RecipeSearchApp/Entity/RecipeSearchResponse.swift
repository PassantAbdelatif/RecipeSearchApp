//
//  RecipeSearchResponse.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class RecipeSearchResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case to
    case count
    case links = "_links"
    case from
    case hits
  }

    init() {
        
    }
  var to: Int?
  var count: Int?
  var links: Links?
  var from: Int?
  var hits: [Hits]?


}
