import Foundation
import Alamofire

class NetworkCall : NSObject{
    
    enum services :String{
        case recipesSearchList = "/api/recipes/v2"
        case recipeDetails = "/api/recipes/v2/"
    }
    var parameters = Parameters()
    var headers = HTTPHeaders()
    var method: HTTPMethod!
    var url :String! = Configuration.baseURL
    var encoding: ParameterEncoding! = JSONEncoding.default
    
    init(data: [String:Any],
         headers: [String:String] = [:],
         url :String?,
         service :services? = nil,
         method: HTTPMethod = .post,
         isJSONRequest: Bool = true ){
        super.init()
        data.forEach{parameters.updateValue($0.value,
                                            forKey: $0.key)}
        headers.forEach({self.headers.add(name: $0.key,
                                          value: $0.value)})
        if url == nil, service != nil{
            self.url += service!.rawValue
        }else{
            self.url = url
        }
        if !isJSONRequest{
            encoding = URLEncoding.queryString
        }
        self.method = method
        print("Service: \(service?.rawValue ?? self.url ?? "") \n data: \(parameters)")
    }
    
    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        AF.request(url,
                   method: method,parameters: parameters,
                   encoding: encoding,
                   headers: headers).responseData(completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode {
                    switch code {
                    case 200...299:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self,
                                                                         from: res)))
                        } catch let error {
                            print(String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                    default:
                        // 300-399 ,400-499
                        do {
                            let businessError = try JSONDecoder().decode(
                                [NetworkError].self,
                                from: res)
                            if businessError.count > 0 {
                                completion(.failure(businessError.first!))
                            }
                        } catch {
                            completion(.failure(NetworkError.parseError))
                        }
                    }
                }
            case .failure(let error):
                
                completion(.failure(error))
            }
        })
    }
}
