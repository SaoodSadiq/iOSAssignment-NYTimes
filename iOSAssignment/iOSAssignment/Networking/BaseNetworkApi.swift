//
//  BaseNetworkApi.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import Foundation

enum NYError: Error {
    case invalidUrl
    case networkError(Error?)
    case dataNotFound
    case jsonParsingError(Error?)
    
    var desc:String {
        switch self {
        case .invalidUrl:
            return "Invalid URL submitted"
        case .networkError(let error):
            return error?.localizedDescription ?? ""
        case .dataNotFound:
            return "Data not Found"
        case .jsonParsingError(let error):
            return error?.localizedDescription ?? ""
        }
    }
    
    static func convertTo(error:Error?, code:Int? = nil) -> NYError {
        switch (error as NSError?)?.code ?? code ?? 1 {
        case 1:
            return .invalidUrl
        default:
            return .networkError(error)
        }
    }
}

enum Result<T:Decodable> {
    case success(T)
    case failure(NYError)
}

protocol BaseNetworkApi {
    func networkRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void)
}

extension BaseNetworkApi {
    func networkRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        if let dataURL = URL(string: url) {
            
            let session = URLSession.shared
            let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
            
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                guard let data = data else {
                    completion(Result.failure(NYError.dataNotFound))
                    return
                }
                guard error == nil else {
                    completion(Result.failure(NYError.convertTo(error: error)))
                    return
                }
                do {
                    let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                    completion(Result.success(decodedObject))
                }
                catch let error {
                    completion(Result.failure(NYError.jsonParsingError(error as? DecodingError)))
                }
            })
            
            task.resume()
        }
        else {
            completion(Result.failure(NYError.invalidUrl))
            return
        }
    }
}
