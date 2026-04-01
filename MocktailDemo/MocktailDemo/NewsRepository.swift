//
//  NewsRepository.swift
//  MocktailDemo
//

import Foundation
import Combine

enum NewsAPI {
    case topHeadlines(country: String)

    var url: URL {
        switch self {
        case .topHeadlines(let country):
            var components = URLComponents()
            components.scheme = "https"
            components.host = "newsapi.org"
            components.path = "/v2/top-headlines"
            components.queryItems = [
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "apiKey", value: "283968034fbc4db691fd4115a1e2daec")
            ]
            return components.url!
        }
    }
}

protocol NewsRepository {
    func fetchTopHeadlines(country: String) -> AnyPublisher<[Article], Error>
}

class NewsRepositoryImpl: NewsRepository {
    func fetchTopHeadlines(country: String) -> AnyPublisher<[Article], Error> {
        URLSession.shared.dataTaskPublisher(for: NewsAPI.topHeadlines(country: country).url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map(\.articles)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
