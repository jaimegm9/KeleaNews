//
//  HomeRobot.swift
//  KeleaNewsUITests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import XCTest

final class HomeRobot: Robot {
    
    private lazy var searchButton = app.buttons[Accessibility.Home.searchButton]
    private lazy var cell = app.buttons[Accessibility.Home.cell]
    
    @discardableResult
    func checkContent() -> Self {
        assert(searchButton, [.exists])
        return self
    }
    
    @discardableResult
    func tapCell() -> DetailRobot {
        tap(cell.firstMatch)
        return DetailRobot(app)
    }
}
