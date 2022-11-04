//
//  Next.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Next: Codable {

  enum CodingKeys: String, CodingKey {
    case href
    case title
  }

  var href: String?
  var title: String?


}
