//
//  ProviderExtension.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 02/11/2022.
//

import Alamofire
import Moya
import PromiseKit
import Moya_ObjectMapper
import ObjectMapper

extension MoyaProvider {
    func CallApi<T1: TargetType, T2: Decodable>(_ target: T1, _ objectType: T2) -> Promise<T2?> {
        
        let provider = MoyaProvider<T1>(plugins: [NetworkLoggerPlugin(verbose: true)])
        
        return Promise<T2?> { (resolver) in
            
            provider.request(target, completion: { (result) in
                
                switch result {
                    
                case let .success(moyaResponse):
                    do {
                        let response  = try JSONDecoder().decode(T2.self,
                                                                 from: moyaResponse.data)

                        
                        guard moyaResponse.statusCode == 200 else {
                            return resolver.reject(NSError(domain: "\(moyaResponse.statusCode)",
                                                    code: moyaResponse.statusCode,
                                                    userInfo: ["response_message": "Response message from server"]))
                        }
                        
                        // http status code is now 200 from here on
                        
                        resolver.fulfill(response)
                        
                    } catch {
                        
                    }
                    
                case let .failure(error):
                    resolver.reject(error)
                }
            })
        }
    }
    
  
}


