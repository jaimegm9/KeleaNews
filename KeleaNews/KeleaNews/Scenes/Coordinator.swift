//
//  Coordinator.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 31/1/24.
//

import SwiftUI

protocol CoordinatorProtocol: AnyObject {
    func openDetail(_ article: Article)
    func openURL(_ url: URL)
}

final class Coordinator: CoordinatorProtocol, ObservableObject {
    @Published var homeViewModel: HomeViewModel!
    @Published var detailViewModel: DetailViewModel!
    @Published var openedURL: IdentifiableURL?
    
    init() {
        self.homeViewModel = HomeViewModel(coordinator: self,
                                           getTopicNewsWorker: GetTopicNewsWorker(),
                                           getTopHeadlinesNewsWorker: GetTopHeadlinesWorker())
    }
    
    func openDetail(_ article: Article) {
        detailViewModel = DetailViewModel(coordinator: self, article: article)
    }
    
    func openURL(_ url: URL) {
        openedURL = IdentifiableURL(id: url)
    }
}

struct IdentifiableURL: Identifiable {
    var id: URL
}
