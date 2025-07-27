//
//  MockResponseLoader.swift
//  MocktailKit
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation

public struct MockResponseLoader {
    private static let mockFolder = "MocktailJsonMaterial"

    public static func loadJSON(named fileName: String, from bundle: Bundle) -> Data? {
        guard let url = Bundle.main.url(forResource: "employees", withExtension: "json", subdirectory: mockFolder) else {
            print("[Mocktail] ❌ File not found: \(mockFolder)/\(fileName)")
            return nil
        }

        return try? Data(contentsOf: url)
    }
}
