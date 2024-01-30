//
//  SessionProtocol.swift
//  
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import Foundation
import Combine

public protocol SessionProtocol {
    func request<T: Decodable>(_ request: NetworkRequest, dataType: T.Type, statusOk: Int) -> AnyPublisher<T, NetworkError>
}
