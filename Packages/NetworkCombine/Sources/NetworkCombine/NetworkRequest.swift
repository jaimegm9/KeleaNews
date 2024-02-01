//
//  NetworkRequest.swift
//  
//
//  Created by jaime.gutierrez.m on 13/5/23.
//

import Foundation

public protocol NetworkRequest {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var timeout: TimeInterval? { get }
}

public extension NetworkRequest {
    var url: URL? {
        var urlComponents = URLComponents(string: self.baseUrl)
        urlComponents?.path.append(self.path)

        if let parameters = self.parameters {
            var queries = [URLQueryItem]()
            for parameter in parameters {
                queries.append(URLQueryItem(name: parameter.key, value: parameter.value as? String))
            }
            urlComponents?.queryItems = queries
        }

        return urlComponents?.url
    }

    func buildURLRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = timeout ?? 60
        if let httpBody = body {
            request.httpBody = try? httpBody.jsonEncode()
        }
        return request
    }

    static func == (lhs: NetworkRequest, rhs: NetworkRequest) -> Bool {
        return lhs.body == rhs.body
        && lhs.headers == rhs.headers
            && lhs.url == rhs.url
            && lhs.method == rhs.method
    }
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum HTTPHeaderField: String {
    case apiKey = "X-Api-Key"
    case authorization = "Authorization"
    case accept = "Accept"
    case contentType = "Content-Type"
    case contentLength = "Content-Length"
    case acceptLanguage = "Accept-Language"
}

public enum HTTPContenType: String {
    case json = "application/json"
    case urlencoded = "application/x-www-form-urlencoded"
    case plain = "text/plain"
    case javascript = "text/javascript"
    case png = "image/png"
    case jpg = "image/jpg"
    case multipart = "multipart/form-data"
}

private extension Encodable {
    func jsonEncode() throws -> Data? {
        try JSONEncoder().encode(self)
    }
}
