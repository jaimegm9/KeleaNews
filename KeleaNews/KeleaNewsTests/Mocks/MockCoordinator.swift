//
//  MockCoordinator.swift
//  KeleaNewsTests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import Foundation
@testable import KeleaNews

final class MockCoordinator: CoordinatorProtocol {
    
    var openDetailCalled: Bool = false
    var articleOpened: Article?
    var openURLCalled: Bool = false
    var urlOpened: URL?
    
    func openDetail(_ article: Article) {
        openDetailCalled = true
        articleOpened = article
    }
    
    func openURL(_ url: URL) {
        openURLCalled = true
        urlOpened = url
    }
}
