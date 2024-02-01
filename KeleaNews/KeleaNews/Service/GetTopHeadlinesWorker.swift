//
//  GetTopHeadlinesWorker.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import Foundation
import NetworkCombine
import Combine


protocol GetTopHeadlinesWorkerProtocol {
    func getTopHeadlinesPublisher(country: String, page: Int) -> AnyPublisher<Articles, NetworkError>
}

class GetTopHeadlinesWorker: GetTopHeadlinesWorkerProtocol {
    func getTopHeadlinesPublisher(country: String, page: Int) -> AnyPublisher<Articles, NetworkError> {
        let request = NewsApiService.getTopHeadlines(country: country, page: page)
        return Session().request(request, dataType: Articles.self)
    }
}
