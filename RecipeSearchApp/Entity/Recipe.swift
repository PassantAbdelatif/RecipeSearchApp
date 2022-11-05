//
//  Recipe.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Recipe: Codable {

  enum CodingKeys: String, CodingKey {
    case calories
    case mealType
    case totalNutrients
    case yield
    case totalTime
    case totalWeight
    case cuisineType
    case dietLabels
    case digest
    case cautions
    case totalDaily
    case images
    case ingredients
    case dishType
    case healthLabels
    case ingredientLines
    case image
    case uri
    case recipeLabel = "label"
    case shareAs
    case source
    case url
  }

  var calories: Float?
  var mealType: [String]?
  var totalNutrients: TotalNutrients?
  var yield: Int?
  var totalTime: Double?
  var totalWeight: Float?
  var cuisineType: [String]?
  var dietLabels: [String]?
  var digest: [Digest]?
  var cautions: [String]?
  var totalDaily: TotalNutrients?
  var images: Images?
  var ingredients: [Ingredients]?
  var dishType: [String]?
  var healthLabels: [String]?
  var ingredientLines: [String]?
  var image: String?
  var uri: String?
  var recipeLabel: String?
  var shareAs: String?
  var source: String?
  var url: String?


}
