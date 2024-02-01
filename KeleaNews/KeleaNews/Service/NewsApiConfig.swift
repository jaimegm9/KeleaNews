//
//  NewsApiConfig.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 30/1/24.
//

import Foundation

enum NewsApiConfig {
    #if CONF_PROD
    static let baseUrl = "https://newsapi.org/v2/"
    static let apiKey = "f240b8b03f614f038fe84656d3162e64"
    #else
    static let baseUrl = "https://newsapi.org/v2/"
    static let apiKey = "f240b8b03f614f038fe84656d3162e64"
    #endif
    
    static let pageSize = 10
}
