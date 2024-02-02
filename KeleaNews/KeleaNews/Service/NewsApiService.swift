//
//  NewsApiService.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 30/1/24.
//

import Foundation
import NetworkCombine

enum NewsApiService: NetworkRequest {
    
    case getRecentNews(topic: String, page: Int)
    case getTopHeadlines(country: String, page: Int)
    
    var baseUrl: String {
        return NewsApiConfig.baseUrl
    }
    
    var path: String {
        switch self {
        case .getRecentNews:
            return "everything"
        case .getTopHeadlines:
            return "top-headlines"
        }
    }
    
    var method: NetworkCombine.HTTPMethod {
        switch self {
        case .getRecentNews, .getTopHeadlines:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        params["pageSize"] = String(NewsApiConfig.pageSize)
        switch self {
        case .getRecentNews(let topic, let page):
            params["q"] = topic
            params["from"] = "2024-01-29" // Decided to select a fixed date because getting the current one sometimes is not returning any article
            params["sortBy"] = "popularity"
            params["page"] = String(page)
        case .getTopHeadlines(let country, let page):
            params["country"] = country
            params["page"] = String(page)
        }
        return params
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers[HTTPHeaderField.apiKey.rawValue] = NewsApiConfig.apiKey
        return headers
    }
    
    var body: Data? {
        nil
    }
    
    var timeout: TimeInterval? {
        50
    }
}
