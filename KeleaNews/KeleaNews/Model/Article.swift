//
//  Article.swift
//  KeleaNews
//
//  Created by jaime.gutierrez.m on 30/1/24.
//

import Foundation

struct Articles: Decodable {
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable, Equatable, Identifiable {
    let id = UUID()
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    struct Source: Decodable, Equatable {
        let id: String?
        let name: String?
    }
}
