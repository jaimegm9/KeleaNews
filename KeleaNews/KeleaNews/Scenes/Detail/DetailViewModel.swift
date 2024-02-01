//
//  DetailViewModel.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 31/1/24.
//

import Foundation

final class DetailViewModel: ObservableObject {
    private unowned let coordinator: CoordinatorProtocol
    
    @Published private(set) var article: Article
    
    init(coordinator: CoordinatorProtocol, article: Article) {
        self.coordinator = coordinator
        self.article = article
    }
    
    func openSafari() {
        guard let urlString = article.url, let url = URL(string: urlString) else { return }
        coordinator.openURL(url)
    }
}
