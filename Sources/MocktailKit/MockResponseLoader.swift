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
        let name = (fileName as NSString).deletingPathExtension
        let ext = (fileName as NSString).pathExtension

        guard let path = bundle.path(forResource: name, ofType: ext) else {
            print("[Mocktail] ❌ Could not find \(fileName)")
            return nil
        }

        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print("[Mocktail] ❌ Failed to read \(fileName): \(error)")
            return nil
        }
    }
}
