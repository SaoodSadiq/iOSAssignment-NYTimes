//
//  LandingViewModel.swift
//  iOSAssignment
//
//  Created by MUhammad Sadiq on 08/05/2023.
//

import Foundation

protocol LandingViewModelProtocol {
    func getPopularNYTimesNews(period: String)
}

class LandingViewModel:ObservableObject, LandingViewModelProtocol {
    
    @Published var articles = [Article]()
    @Published var error: NYError?
    @Published var showProgress:Bool = false
    @Published var showAlert:Bool = false
           
    let nyTimesApiManager:NYTimesApiManager!
    
    init(nyTimesApiManager: NYTimesApiManager) {
        self.nyTimesApiManager = NYTimesApiManager()
        self.getPopularNYTimesNews(period: "7")
    }
    
    func getPopularNYTimesNews(period: String) {
        showProgress = true
        nyTimesApiManager.getPopularArticle(period: period, type: NYArticle.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.showProgress = false
                switch result {
                case .success(let data):
                    self?.articles = data.results?.sorted(by: {$0.published_date ?? "" > $1.published_date ?? ""}) ?? [Article]()
                case .failure(let error):
                    self?.error = error
                    self?.showAlert = true
                    print(error)
                }
            }
        }
    }
    
    func resetError() {
        self.error = nil
        self.showAlert = false
    }
}
