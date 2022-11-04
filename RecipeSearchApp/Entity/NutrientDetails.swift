//
//  NA.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class NutrientDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case label
    case unit
    case quantity
  }

  var label: String?
  var unit: String?
  var quantity: Double?


}
