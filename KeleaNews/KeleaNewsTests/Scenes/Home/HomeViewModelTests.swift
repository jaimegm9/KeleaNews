//
//  HomeViewModelTests.swift
//  KeleaNewsTests
//
//  Created by jaime.gutierrez.m on 29/1/24.
//

import XCTest
@testable import KeleaNews
import Combine
import NetworkCombine

final class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!
    private var coordinator: MockCoordinator!
    private var getTopicNewsWorker: MockGetTopicNewsWorker!
    private var getTopHeadlinesNewsWorker: MockGetTopHeadlinesWorker!
    private var subscriptions: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        subscriptions = []
        getTopicNewsWorker = MockGetTopicNewsWorker()
        getTopHeadlinesNewsWorker = MockGetTopHeadlinesWorker()
        coordinator = MockCoordinator()
        sut = HomeViewModel(coordinator: coordinator,
                            getTopicNewsWorker: getTopicNewsWorker,
                            getTopHeadlinesNewsWorker: getTopHeadlinesNewsWorker)
    }

    override func tearDownWithError() throws {
        sut = nil
        getTopicNewsWorker = nil
        getTopHeadlinesNewsWorker = nil
        coordinator = nil
        subscriptions = nil
        try super.tearDownWithError()
    }
    
    func test_given_get_top_news_when_success_then_status_loaded() throws {
        let expectedState: HomeState = .loaded(ArticlesMock.articles)
        let expectation = XCTestExpectation(description: "State is set")
        
        sut.$state.dropFirst().sink { state in
            XCTAssertEqual(state, expectedState)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        getTopHeadlinesNewsWorker.result = Result.success(ArticlesMock.articlesObject).publisher.eraseToAnyPublisher()
        sut.getArticles()
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_given_get_topic_news_when_success_then_status_loaded() throws {
        let expectedState: HomeState = .loaded(ArticlesMock.articles)
        let expectation = XCTestExpectation(description: "State is set")
        
        sut.searchText = "iOS"
        
        sut.$state.dropFirst().sink { state in
            XCTAssertEqual(state, expectedState)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        getTopicNewsWorker.result = Result.success(ArticlesMock.articlesObject).publisher.eraseToAnyPublisher()
        sut.getArticles()
        
        wait(for: [expectation], timeout: 2)
    }

    func test_given_get_news_when_unexpected_status_code_then_status_error() throws {
        let expectedState: HomeState = .error("Unexpected error")
        let expectation = XCTestExpectation(description: "State is set")
        
        sut.$state.dropFirst().sink { state in
            XCTAssertEqual(state, expectedState)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        getTopHeadlinesNewsWorker.result = Result.failure(NetworkError.unexpectedStatusCode(code: 300)).publisher.eraseToAnyPublisher()
        sut.getArticles()
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_given_get_news_when_401_status_code_then_status_error() throws {
        let expectedState: HomeState = .error("Token error")
        let expectation = XCTestExpectation(description: "State is set")
        
        sut.$state.dropFirst().sink { state in
            XCTAssertEqual(state, expectedState)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        getTopHeadlinesNewsWorker.result = Result.failure(NetworkError.unexpectedStatusCode(code: 401)).publisher.eraseToAnyPublisher()
        sut.getArticles()
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_given_get_news_when_unexpected_error_then_status_error() throws {
        let expectedState: HomeState = .error("Unexpected error")
        let expectation = XCTestExpectation(description: "State is set")
        
        sut.$state.dropFirst().sink { state in
            XCTAssertEqual(state, expectedState)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        getTopHeadlinesNewsWorker.result = Result.failure(NetworkError.general(code: 1, error: "")).publisher.eraseToAnyPublisher()
        sut.getArticles()
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_given_get_news_when_no_results_then_status_loaded_with_no_results() throws {
        let expectedState: HomeState = .loaded([])
        let expectation = XCTestExpectation(description: "State is set")
        
        sut.$state.dropFirst().sink { state in
            XCTAssertEqual(state, expectedState)
            XCTAssertTrue(self.sut.noResults)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        getTopHeadlinesNewsWorker.result = Result.success(ArticlesMock.articlesNoItems).publisher.eraseToAnyPublisher()
        sut.getArticles()
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_given_loading_and_get_news_then_loading_state() {
        let expectedState: HomeState = .loading
        sut.loadingAndGetNews()
        
        XCTAssertEqual(expectedState, sut.state)
    }
    
    func test_given_load_more_news_then_two_pages_are_loaded() {
        let expectedState: HomeState = .loaded(ArticlesMock.articlesx2)
        let expectation = XCTestExpectation(description: "State is set")
        
        sut.state = .loaded(ArticlesMock.articles)
        
        sut.$state.dropFirst().sink { state in
            XCTAssertEqual(state, expectedState)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        getTopHeadlinesNewsWorker.result = Result.success(ArticlesMock.articlesObject).publisher.eraseToAnyPublisher()
        sut.loadMoreArticlesIfNeeded(article: ArticlesMock.article2)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_tap_new_open_detail() {
        sut.openDetail(ArticlesMock.article1)
        
        XCTAssertEqual(ArticlesMock.article1, coordinator.articleOpened)
        XCTAssertTrue(coordinator.openDetailCalled)
    }
}
