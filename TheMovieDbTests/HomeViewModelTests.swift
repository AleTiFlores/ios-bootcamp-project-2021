//
//  MockMovieClient.swift
//  TheMovieDbTests
//
//  Created by Alex on 29/11/21.
//

import XCTest
@testable import TheMovieDb

final class HomeViewModelTests: XCTestCase {
    
    static var resource: String!
    
    var viewModel: HomeViewModel!
    
    var isLoading: (() -> Void)?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        viewModel = nil
        isLoading = nil
        HomeViewModelTests.resource = nil
        super.tearDown()
        
    }
    
    // MARK: Non Mock (end to end) Unit Tests
    
    func test_getMovies() {
        viewModel = HomeViewModel(client: MovieClient(), categories: Category.defaultCategories)
       
        let expectation = expectation(description: "Expected categories")
        viewModel.isLoading = {
            
            XCTAssertFalse(self.viewModel.categories.isEmpty)
            XCTAssertEqual(self.viewModel.categories.count, 5)
            
            expectation.fulfill()
        }
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: Mock Unit Tests
    
    func test_mockGetMoviesTrending() {
        HomeViewModelTests.resource = "Trending"
        let category = Category(name: HomeViewModelTests.resource, path: MovieDbEndPoints.trendingUrl, movies: [], color: UIColor.customRed)
        viewModel = HomeViewModel(client: MockMovieClient(), categories: [category])
        
        let expectation = expectation(description: "Expected categories")
        viewModel.isLoading = {
            
            XCTAssertFalse(self.viewModel.categories.isEmpty)
            XCTAssertEqual(self.viewModel.categories.count, 1)
            XCTAssertEqual(self.viewModel.categories.first?.movies.count, 20)
            XCTAssertEqual(self.viewModel.categories.first?.movies.first?.title, "Venom: Let There Be Carnage")
            expectation.fulfill()
        }
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_mockGetMoviesTopRated() {
        HomeViewModelTests.resource = "TopRated"
        let category = Category(name: HomeViewModelTests.resource, path: MovieDbEndPoints.trendingUrl, movies: [], color: UIColor.customGreen)
        viewModel = HomeViewModel(client: MockMovieClient(), categories: [category])
      
        let expectation = expectation(description: "Expected categories")
        viewModel.isLoading = {
            
            XCTAssertFalse(self.viewModel.categories.isEmpty)
            XCTAssertEqual(self.viewModel.categories.count, 1)
            XCTAssertEqual(self.viewModel.categories.first?.movies.count, 20)
            XCTAssertEqual(self.viewModel.categories.first?.movies.first?.title, "Dilwale Dulhania Le Jayenge")
            expectation.fulfill()
        }
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_mockGetMoviesUpcoming() {
        HomeViewModelTests.resource = "Upcoming"
        let category = Category(name: HomeViewModelTests.resource, path: MovieDbEndPoints.trendingUrl, movies: [], color: UIColor.customBlue)
        viewModel = HomeViewModel(client: MockMovieClient(), categories: [category])
        
        let expectation = expectation(description: "Expected categories")
        viewModel.isLoading = {
            
            XCTAssertFalse(self.viewModel.categories.isEmpty)
            XCTAssertEqual(self.viewModel.categories.count, 1)
            XCTAssertEqual(self.viewModel.categories.first?.movies.count, 20)
            XCTAssertEqual(self.viewModel.categories.first?.movies.first?.title, "Venom: Let There Be Carnage")
            expectation.fulfill()
        }
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_mockGetMoviesNowPlaying() {
        HomeViewModelTests.resource = "NowPlaying"
        let category = Category(name: HomeViewModelTests.resource, path: MovieDbEndPoints.trendingUrl, movies: [], color: UIColor.customPurple)
        viewModel = HomeViewModel(client: MockMovieClient(), categories: [category])
       
        let expectation = expectation(description: "Expected categories")
        viewModel.isLoading = {
            
            XCTAssertFalse(self.viewModel.categories.isEmpty)
            XCTAssertEqual(self.viewModel.categories.count, 1)
            XCTAssertEqual(self.viewModel.categories.first?.movies.count, 20)
            XCTAssertEqual(self.viewModel.categories.first?.movies.first?.title, "Venom: Let There Be Carnage")
            expectation.fulfill()
        }
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_mockGetMoviesPopular() {
        HomeViewModelTests.resource = "Popular"
        let category = Category(name: HomeViewModelTests.resource, path: MovieDbEndPoints.trendingUrl, movies: [], color: UIColor.customGray)
        viewModel = HomeViewModel(client: MockMovieClient(), categories: [category])
       
        let expectation = expectation(description: "Expected categories")
        viewModel.isLoading = {
            
            XCTAssertFalse(self.viewModel.categories.isEmpty)
            XCTAssertEqual(self.viewModel.categories.count, 1)
            XCTAssertEqual(self.viewModel.categories.first?.movies.count, 20)
            XCTAssertEqual(self.viewModel.categories.first?.movies.first?.title, "Venom: Let There Be Carnage")
            expectation.fulfill()
        }
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_mockGetMoviesError() {
        HomeViewModelTests.resource = "Error"
        let category = Category(name: HomeViewModelTests.resource, path: MovieDbEndPoints.trendingUrl, movies: [], color: UIColor.systemPink)
        viewModel = HomeViewModel(client: MockMovieClient(), categories: [category])
       
        let expectation = expectation(description: "Expected error")

        viewModel.hasError = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        viewModel.getMovies()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
