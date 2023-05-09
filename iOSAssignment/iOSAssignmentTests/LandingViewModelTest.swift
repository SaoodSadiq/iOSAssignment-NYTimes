//
//  LandingViewModelTest.swift
//  iOSAssignmentTests
//
//  Created by MUhammad Sadiq on 09/05/2023.
//

import XCTest

final class LandingViewModelTest: XCTestCase {

    var viewModel: LandingViewModel!
    
    override func setUp() {
        super.setUp()
        let apiManager = NYTimesApiManager()
        viewModel = LandingViewModel(nyTimesApiManager: apiManager)
    }
    
    func testGetPopularNYTimesNewsOf7days() {
        let expectation = self.expectation(description: "Get popular news from NYTimes API")
        
        viewModel.getPopularNYTimesNews(period: "7")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Wait for 2 seconds to allow the API call to complete
            XCTAssertFalse(self.viewModel.articles.isEmpty, "Articles list should not be empty after API call")
            XCTAssertNil(self.viewModel.error, "Error should be nil after successful API call")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil) // Wait for 5 seconds for the expectation to be fulfilled
    }
    
    func testGetPopularNYTimesNewsOf30days() {
        let expectation = self.expectation(description: "Get popular news from NYTimes API")
        
        viewModel.getPopularNYTimesNews(period: "30")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Wait for 2 seconds to allow the API call to complete
            XCTAssertFalse(self.viewModel.articles.isEmpty, "Articles list should not be empty after API call")
            XCTAssertNil(self.viewModel.error, "Error should be nil after successful API call")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil) // Wait for 5 seconds for the expectation to be fulfilled
    }
    
    func testGetPopularNYTimesNews() {
        let mockApiManager = NYTimesApiManager()
        let viewModel = LandingViewModel(nyTimesApiManager: mockApiManager)
        viewModel.getPopularNYTimesNews(period: "7")
        XCTAssertNil(viewModel.error)
    }
    
    func testShowProgress() {
        let mockApiManager = NYTimesApiManager()
        let viewModel = LandingViewModel(nyTimesApiManager: mockApiManager)
        viewModel.getPopularNYTimesNews(period: "7")
        XCTAssertTrue(viewModel.showProgress)
        // Wait for the network request to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertFalse(viewModel.showProgress)
        }
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

