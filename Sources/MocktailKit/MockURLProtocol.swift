//
//  MockURLProtocol.swift
//  MocktailKit
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation

public final class MockURLProtocol: URLProtocol, @unchecked Sendable {
    private static let handledKey = "MockURLProtocolHandled"

    // Passthrough session — no MockURLProtocol to avoid infinite recursion
    private static let passthroughSession: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = []
        return URLSession(configuration: config)
    }()

    private var passthroughTask: URLSessionDataTask?

    public override class func canInit(with request: URLRequest) -> Bool {
        guard URLProtocol.property(forKey: handledKey, in: request) == nil else { return false }
        guard let scheme = request.url?.scheme else { return false }
        return scheme == "http" || scheme == "https"
    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    public override func startLoading() {
        let path = request.url?.path ?? ""

        // Resolve mock data synchronously using a semaphore.
        // Safe: Mocktail actor runs on the Swift concurrency pool (not main thread),
        // and we only read mockBox.data after semaphore.signal() guarantees the write is done.
        let mockBox = MockDataBox()
        let semaphore = DispatchSemaphore(value: 0)

        Task {
            if let fileName = await Mocktail.shared.getMockFile(for: path) {
                mockBox.data = MockResponseLoader.loadJSON(named: fileName, from: .main)
            }
            semaphore.signal()
        }
        semaphore.wait()

        if let data = mockBox.data, let url = request.url,
           let response = HTTPURLResponse(
               url: url,
               statusCode: 200,
               httpVersion: "HTTP/1.1",
               headerFields: ["Content-Type": "application/json"]
           ) {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else {
            // Path not registered — forward to the real network
            let mutableRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
            URLProtocol.setProperty(true, forKey: Self.handledKey, in: mutableRequest)

            passthroughTask = Self.passthroughSession.dataTask(with: mutableRequest as URLRequest) { [weak self] data, response, error in
                guard let self else { return }
                if let response {
                    self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
                if let data {
                    self.client?.urlProtocol(self, didLoad: data)
                }
                if let error {
                    self.client?.urlProtocol(self, didFailWithError: error)
                } else {
                    self.client?.urlProtocolDidFinishLoading(self)
                }
            }
            passthroughTask?.resume()
        }
    }

    public override func stopLoading() {
        passthroughTask?.cancel()
    }
}

// MARK: - Helpers

/// Thread-safe box used to pass Data out of a Task into a semaphore-guarded context.
/// @unchecked Sendable is safe here because we guarantee write-before-read via the semaphore.
private final class MockDataBox: @unchecked Sendable {
    var data: Data?
}
