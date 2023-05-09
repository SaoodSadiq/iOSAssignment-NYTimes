//
//  NYTimesApi.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import Foundation

fileprivate enum NYTimesApi {
    case mostPopularArticles
    
    var baseUrl: String {
        return "https://api.nytimes.com"
    }
    
    var apiKey: String {
        return "9gf3ItIsYFuwGc6eDhw5RefUAguNXkbd"
    }
    
    var url:String {
        
        switch self {
        case .mostPopularArticles:
            return "\(baseUrl)/svc/mostpopular/v2/mostviewed/all-sections/{period}.json?api-key=\(apiKey)"
        }
    }
}

struct NYTimesApiClient: BaseNetworkApi {
    
    func getPopularArticle<T:Decodable>(period:String, type:T.Type, completion : @escaping (Result<T>) -> Void) {
    
        let url = NYTimesApi.mostPopularArticles.url.replacingOccurrences(of: "{period}", with: period)
        
        self.networkRequest(with: url, objectType: type) { (result: Result<T>) in
            completion(result)
        }
    }
}
