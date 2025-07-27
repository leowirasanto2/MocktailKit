//
//  MockURLProtocol.swift
//  MocktailKit
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation
import Combine

//TODO: let's try to intercept the response here ya

public final class MockURLProtocol: URLProtocol {
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    public override func startLoading() {
        self.client?.urlProtocol(self, didFailWithError: NSError(domain: "Mocktail", code: -1))
    }


    public override func stopLoading() {
        // No-op
    }
}
