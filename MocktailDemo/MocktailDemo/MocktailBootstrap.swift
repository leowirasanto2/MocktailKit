//
//  MocktailBootstrap.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation
import MocktailKit

public enum MocktailBootstrap {
    public static func register() {
        Task {
            await Mocktail.shared.configure(
                mappings: Self.loadMappings()
            )
        }
    }

    private static func loadMappings() -> [String: String] {
        return [
            "/v1/employee/all": "employees.json",
            "/v1/role/all": "roles.json"
        ]
    }
}
