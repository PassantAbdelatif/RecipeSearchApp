//
//  LARGE.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class ImageDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case url
    case height
    case width
  }

  var url: String?
  var height: Int?
  var width: Int?


}
