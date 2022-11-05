//
//  Networkresponse.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 02/11/2022.
//

import Foundation

struct NetworkResponse<T: Codable>: Codable {

    var data: T?
    var error: NetworkError?
}

class GeneralResponse <T: Decodable>: NSObject,  Decodable{

    var code: Int
    var status: Bool
    var message: String?
    var response : T?
}
