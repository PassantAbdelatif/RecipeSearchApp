//
//  NetworkError.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 02/11/2022.
//

import Foundation
import Moya

enum `Type`:String, Codable {
    case business
    case system
    case mapping
    case auth
    case network
}

struct NetworkError: Codable, Error, LocalizedError {
    
    var message: String?
    var type: Type?
    
    init () {}
    
    init(error: MoyaError) {
        self.message = error.errorDescription
        
        switch error {
        case .underlying(let error, _):
            
            let nError = error as NSError
            if (999...1017) ~= abs(nError.code ) {
                
                self.type = .network
                self.message = "no Internet"
                print(error)
                
            } else {
                self.type = .system
                print(error)
                if let networkError = error as? NetworkError {
                    self = networkError
                }
            }
        default :
            self.type = .mapping
        }
    }
    
    var errorDescription: String? {
        return self.message
    }
}

extension NetworkError {
    
    static let parseError: NetworkError = {
        var error = NetworkError()
        error.type = Type.mapping
        return error
    }()
    
    static let authorizeError: NetworkError = {
        var error = NetworkError()
        error.message = "sessionExpired"
        error.type = Type.auth
        return error
    }()
    
    static let generalError: NetworkError = {
        var error = NetworkError()
        error.message = "someThingWentWrong"
        error.type = Type.network
        return error
    }()
}

struct TError: Codable {
    var networkError: NetworkError?
}

extension Error {
    var message: String? {
        return (self as? NetworkError)?.message
    }
    
    var isNetwork: Bool {
        return ((self as? NetworkError)?.type ?? .system) == .network
    }
}
