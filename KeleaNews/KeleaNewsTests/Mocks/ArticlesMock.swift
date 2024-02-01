//
//  ArticlesMock.swift
//  KeleaNewsTests
//
//  Created by jaime.gutierrez.m on 1/2/24.
//

import Foundation
@testable import KeleaNews

enum ArticlesMock {
    
    static let articlesNoItems = Articles(totalResults: 0, articles: [])
    
    static let articlesObject = Articles(totalResults: 2, articles: [article1, article2])
    
    static let articles = [article1, article2]
    
    static let articlesx2 = [article1, article2, article1, article2]
    
    static let article1 = Article(source: Article.Source(id: "id", name: "Apple"),
                                  author: "Jaime",
                                  title: "Kelea test",
                                  description: "iOS Test",
                                  url: "https://www.google.com",
                                  urlToImage: nil,
                                  publishedAt: nil,
                                  content: "Lorem ipsum dolor sit amet consectetur adipiscing elit")
    
    static let article2 = Article(source: Article.Source(id: "id", name: "iOS"),
                                  author: "Gutierrez",
                                  title: "Kelea test",
                                  description: "iOS Test",
                                  url: nil,
                                  urlToImage: nil,
                                  publishedAt: nil,
                                  content: "Lorem ipsum dolor sit amet")
}
