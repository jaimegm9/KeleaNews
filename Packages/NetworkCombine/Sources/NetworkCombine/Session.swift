//
//  Session.swift
//  
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import Foundation
import Combine

public class Session: SessionProtocol {
    public let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request<T: Decodable>(_ request: NetworkRequest, dataType: T.Type, statusOk: Int = 200) -> AnyPublisher<T, NetworkError> {
        guard let url = request.url else {
            return AnyPublisher(Fail<T, NetworkError>(error: NetworkError.badURL))
        }
        
        let urlRequest = request.buildURLRequest(with: url)
        DLog("➡️ \(urlRequest.cURL)")
        return session
            .dataTaskPublisher(for: urlRequest)
            .mapError {
                NetworkError.general(code: $0.code.rawValue, error: $0.localizedDescription)
            }
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.nonHTTP
                }
                if response.statusCode != statusOk {
                    throw NetworkError.unexpectedStatusCode(code: response.statusCode)
                }
                return output.data
            }
            .decode(type: dataType, decoder: JSONDecoder())
            .mapError {
                if let nError = $0 as? NetworkError {
                    DLog("🛑 \(nError.description)")
                    return nError
                }
                let decodeError = NetworkError.decoding(String(describing: $0))
                DLog("⚠️ \(decodeError.description)")
                return decodeError
            }
            .eraseToAnyPublisher()
    }
}
