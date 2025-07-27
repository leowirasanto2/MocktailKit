//
//  MocktailOverlay.swift
//  MocktailKit
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//
import SwiftUI

public struct MocktailOverlay: View {
    public init() {}

    public var body: some View {
        VStack {
            Text("🔍 Mocktail Overlay")
                .font(.title)
                .padding()
            Text("This is where you'd show registered routes or toggle mocks.")
                .font(.subheadline)
                .padding()
        }
    }
}
