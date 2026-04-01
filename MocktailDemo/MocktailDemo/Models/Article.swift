//
//  Article.swift
//  MocktailDemo
//

import Foundation

struct ArticleSource: Codable {
    let id: String?
    let name: String?
}

struct Article: Codable, Identifiable {
    var id: String { url ?? UUID().uuidString }
    let source: ArticleSource?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, content
        case urlToImage
        case publishedAt
    }
}

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
