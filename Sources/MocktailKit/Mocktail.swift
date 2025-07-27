//
//  Mocktail.swift
//  MocktailKit
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//
import Foundation

public actor Mocktail {
    public static let shared = Mocktail()

    private var mappings: [String: String] = [:]
    private var basePath: String = ""

    public func configure(mappings: [String: String]) {
        self.mappings.merge(mappings) { _, new in new }
    }

    public func register(route: String, fileName: String) {
        mappings[route] = fileName
    }

    public func getMockFile(for route: String) -> String? {
        return mappings[route]
    }
    
    public func getBasePath() -> String? {
        return basePath
    }
    
    public func provide<T: Decodable>(_ route: String, as type: T.Type) async throws -> T {
        guard let fileName = mappings["\(route)"] else {
            throw NSError(domain: "Mocktail", code: 404, userInfo: [NSLocalizedDescriptionKey: "No mock registered for \(route)"])
        }

        guard let data = MockResponseLoader.loadJSON(named: fileName) else {
            throw NSError(domain: "Mocktail", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to load mock file: \(fileName)"])
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

}
