//
//  DetailViewModelTests.swift
//  KeleaNewsTests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import XCTest
@testable import KeleaNews
import Combine
import NetworkCombine

final class DetailViewModelTests: XCTestCase {
    
    private var sut: DetailViewModel!
    private var coordinator: MockCoordinator!
    private var article: Article!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coordinator = MockCoordinator()
        article = ArticlesMock.article1
        sut = DetailViewModel(coordinator: coordinator,
                              article: article)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        coordinator = nil
        article = nil
        try super.tearDownWithError()
    }
    
    func test_given_tap_safari_button_go_to_safari() {
        
        sut.openSafari()
        
        let expectedURL = URL(string: "https://www.google.com")
        XCTAssertEqual(expectedURL, coordinator.urlOpened)
        XCTAssertTrue(coordinator.openURLCalled)
    }
}
