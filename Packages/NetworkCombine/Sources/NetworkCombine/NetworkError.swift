//
//  NetworkError.swift
//  
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case general(code: Int, error: String)
    case decoding(_ error: String)
    case unexpectedStatusCode(code: Int)
    case nonHTTP
    case unknown(code: Int, error: String)
    
    var description: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .general(let code, let error):
            return "General error:\(error) code: \(code)."
        case .decoding(let error):
            return "JSON error: \(error)."
        case .unexpectedStatusCode(let code):
            return "\(code) - Unexpected status code"
        case .nonHTTP:
            return "Non HTTP connection."
        case .unknown(let code, let error):
            return "Unknown error:\(error) code: \(code)."
        }
    }
}
