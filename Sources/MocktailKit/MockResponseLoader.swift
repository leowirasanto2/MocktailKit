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
        // Remove .json extension if already present
        let resourceName = fileName.hasSuffix(".json") ? String(fileName.dropLast(5)) : fileName

        print("[Mocktail] 🔍 Looking for: \(resourceName).json in \(mockFolder)/")
        print("[Mocktail] 📦 Bundle: \(bundle.bundlePath)")

        guard let url = bundle.url(forResource: resourceName, withExtension: "json", subdirectory: mockFolder) else {
            print("[Mocktail] ❌ File not found: \(mockFolder)/\(resourceName).json")

            if let folderURL = bundle.url(forResource: nil, withExtension: nil, subdirectory: mockFolder),
               let contents = try? FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil) {
                print("[Mocktail] 📁 Available files in \(mockFolder):")
            } else {
                print("[Mocktail] 📁 MocktailJsonMaterial folder not found in bundle")
            }

            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            print("[Mocktail] ✅ Successfully loaded: \(resourceName).json (\(data.count) bytes)")
            return data
        } catch {
            print("[Mocktail] ❌ Error reading file: \(error)")
            return nil
        }
    }

    public static func loadJSON(named fileName: String) -> Data? {
        return loadJSON(named: fileName, from: Bundle.main)
    }
}
