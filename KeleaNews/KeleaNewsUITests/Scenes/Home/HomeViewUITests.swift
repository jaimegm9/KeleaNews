//
//  HomeViewUITests.swift
//  KeleaNewsUITests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import XCTest

final class HomeViewUITests: XCTestCase {
    
    private lazy var app = XCUIApplication()
    
    func test_home_view_content() {
        HomeRobot(app)
            .start()
            .checkContent()
    }
    
    func test_tap_cell_navigate_detail_check_content_go_back() {
        HomeRobot(app)
            .start()
            .checkContent()
            .tapCell()
            .checkContent()
            .navigateBack()
            .tapCell()
    }
}
