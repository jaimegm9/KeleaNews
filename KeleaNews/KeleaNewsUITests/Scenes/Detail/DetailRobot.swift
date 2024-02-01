//
//  DetailRobot.swift
//  KeleaNewsUITests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import XCTest

final class DetailRobot: Robot {
    
    private lazy var title = app.staticTexts[Accessibility.Detail.title]
    private lazy var content = app.staticTexts[Accessibility.Detail.content]
    private lazy var closeButton = app.buttons[Accessibility.Detail.closeButton]
    private lazy var safariButton = app.buttons[Accessibility.Detail.safariButton]
    
    @discardableResult
    func checkContent() -> Self {
        assert(title, [.exists])
        assert(content, [.exists])
        assert(closeButton, [.exists])
        assert(safariButton, [.exists])
        return self
    }
    
    func navigateBack() -> HomeRobot {
        tap(closeButton)
        return HomeRobot(app)
    }
}
