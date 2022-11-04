//
//  Digest.swift
//
//  Created by Passant Abdelatif on 04/11/2022
//  Copyright (c) . All rights reserved.
//

import Foundation

class Digest: Codable {

  enum CodingKeys: String, CodingKey {
    case label
    case daily
    case total
    case hasRDI
    case schemaOrgTag
    case tag
    case unit
    case sub
  }

  var label: String?
  var daily: Double?
  var total: Double?
  var hasRDI: Bool?
  var schemaOrgTag: String?
  var tag: String?
  var unit: String?
  var sub: [Digest]?


}
