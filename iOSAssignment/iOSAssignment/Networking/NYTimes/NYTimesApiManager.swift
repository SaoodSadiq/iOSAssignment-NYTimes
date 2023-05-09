//
//  NYTimesApiManager.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import Foundation

struct NYTimesApiManager {
    
    private let client = NYTimesApiClient()
    
    func getPopularArticle<T:Decodable>(period:String, type:T.Type, completion : @escaping (Result<T>) -> Void) {
        client.getPopularArticle(period: period, type: type, completion: completion)
    }
}
