//
//  HomeViewModel.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 30/1/24.
//

import Foundation
import Combine
import NetworkCombine

enum HomeState: Equatable {
    case loading
    case loaded([Article])
    case error(String)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded(let lhsArticles), .loaded(let rhsArticles)):
            return lhsArticles == rhsArticles
        case(.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}

final class HomeViewModel: ObservableObject {
    private unowned let coordinator: CoordinatorProtocol
    
    @Published var state: HomeState = .loading
    @Published var noResults: Bool = false
    var searchText = ""
    
    private let getTopicNewsWorker: GetTopicNewsWorkerProtocol
    private let getTopHeadlinesNewsWorker: GetTopHeadlinesWorkerProtocol
    private var subscriptions = Set<AnyCancellable>()
    private var page = 1
    
    init(coordinator: CoordinatorProtocol,
         getTopicNewsWorker: GetTopicNewsWorkerProtocol,
         getTopHeadlinesNewsWorker: GetTopHeadlinesWorkerProtocol) {
        self.coordinator = coordinator
        self.getTopicNewsWorker = getTopicNewsWorker
        self.getTopHeadlinesNewsWorker = getTopHeadlinesNewsWorker
    }
    
    func loadingAndGetNews() {
        page = 1
        state = .loading
        getArticles()
    }
    
    func getArticles() {
        
        if searchText.isEmpty {
            getNews(publisher: getTopHeadlinesNewsWorker.getTopHeadlinesPublisher(country: getCurrentCountry(), page: page))
        } else {
            getNews(publisher: getTopicNewsWorker.getRecentNewsPublisher(topic: searchText, page: page))
        }
    }
    
    private func getNews(publisher: AnyPublisher<Articles, NetworkError>) {
        publisher
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(let error) = completion {
                    if case .unexpectedStatusCode(code: let code) = error {
                        self.state = code == 401 ? .error("Token error") : .error("Unexpected error")
                    } else {
                        self.state = .error("Unexpected error")
                    }
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.noResults = response.articles.isEmpty
                if case .loaded(let articles) = self.state {
                    var news = articles
                    news.append(contentsOf: response.articles)
                    self.state = .loaded(news)
                } else {
                    self.state = .loaded(response.articles)
                }
            }
            .store(in: &subscriptions)
    }
    
    func loadMoreArticlesIfNeeded(article: Article) {
        if isLastCell(article: article) {
            page += 1
            getArticles()
        }
    }
    
    func isLastCell(article: Article) -> Bool {
        if case .loaded(let articles) = state {
            return articles.last == article
        }
        return false
    }
    
    func openDetail(_ article: Article) {
        coordinator.openDetail(article)
    }
    
    private func getCurrentCountry() -> String {
        let country = Locale.current.regionCode ?? "us"
        // The news api doesn't have Spain ('es') as valid option for a country
        // so for testing purposes, if that's the case, we change it to 'us'
        return (country == "ES") ? "us" : country
    }
}
