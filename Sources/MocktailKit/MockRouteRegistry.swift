//
//  MockRouteRegistry.swift
//  MocktailKit
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation

// TODO: This file is not used in the current MVP.
// It will be useful when we implement URLRequest-based interception using URLProtocol,
// allowing automatic route resolution from live requests.

public struct MockRoute: Hashable {
    public let method: String
    public let path: String

    public init(method: String, path: String) {
        self.method = method.uppercased()
        self.path = path
    }

    public var identifier: String {
        return "\(method):\(path)"
    }
}

public struct MockRouteRegistry {
    public static func resolve(from request: URLRequest) -> MockRoute? {
        guard
            let url = request.url,
            let method = request.httpMethod
        else {
            return nil
        }

        // Strip off scheme, host, query to just get the path
        let path = url.path

        return MockRoute(method: method, path: path)
    }
}
