//
//  GetTopicNewsWorker.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 30/1/24.
//

import Foundation
import NetworkCombine
import Combine

protocol GetTopicNewsWorkerProtocol {
    func getRecentNewsPublisher(topic: String, page: Int) -> AnyPublisher<Articles, NetworkError>
}

class GetTopicNewsWorker: GetTopicNewsWorkerProtocol {
    func getRecentNewsPublisher(topic: String, page: Int) -> AnyPublisher<Articles, NetworkError> {
        let request = NewsApiService.getRecentNews(topic: topic, page: page)
        return Session().request(request, dataType: Articles.self)
    }
}
