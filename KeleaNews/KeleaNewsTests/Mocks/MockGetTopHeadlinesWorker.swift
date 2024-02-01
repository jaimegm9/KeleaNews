//
//  MockGetTopHeadlinesWorker.swift
//  KeleaNewsTests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import Foundation
@testable import KeleaNews
import Combine
import NetworkCombine

final class MockGetTopHeadlinesWorker: GetTopHeadlinesWorkerProtocol {
    
    var result: AnyPublisher<Articles, NetworkError> = Result.failure(NetworkError.unexpectedStatusCode(code: 300)).publisher.eraseToAnyPublisher()
    
    func getTopHeadlinesPublisher(country: String, page: Int) -> AnyPublisher<Articles, NetworkError> {
        return result
    }
}
