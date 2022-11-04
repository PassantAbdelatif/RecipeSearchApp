//
//  Images.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Images: Codable {

  enum CodingKeys: String, CodingKey {
    case sMALL = "SMALL"
    case rEGULAR = "REGULAR"
    case tHUMBNAIL = "THUMBNAIL"
    case lARGE = "LARGE"
  }

  var sMALL: ImageDetails?
  var rEGULAR: ImageDetails?
  var tHUMBNAIL: ImageDetails?
  var lARGE: ImageDetails?


}
