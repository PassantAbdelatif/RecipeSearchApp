//
//  Ingredients.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Ingredients: Codable {

  enum CodingKeys: String, CodingKey {
    case measure
    case text
    case image
    case food
    case foodId
    case weight
    case foodCategory
    case quantity
  }

  var measure: String?
  var text: String?
  var image: String?
  var food: String?
  var foodId: String?
  var weight: Double?
  var foodCategory: String?
  var quantity: Float?


}
