//
//  DotaRepository.swift
//  MocktailDemo
//

import Foundation
import Combine
import MocktailKit

enum DotaAPI {
    case heroes

    var path: String {
        switch self {
        case .heroes:
            return "/api/heroes"
        }
    }

    var url: URL {
        switch self {
        case .heroes:
            return URL(string: "https://api.opendota.com\(path)")!
        }
    }
}

protocol DotaRepository {
    func fetchHeroes() -> AnyPublisher<[DotaHero], Error>
}

class DotaRepositoryImpl: DotaRepository {
    func fetchHeroes() -> AnyPublisher<[DotaHero], Error> {
        URLSession.shared.dataTaskPublisher(for: DotaAPI.heroes.url)
            .map(\.data)
            .decode(type: [DotaHero].self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
