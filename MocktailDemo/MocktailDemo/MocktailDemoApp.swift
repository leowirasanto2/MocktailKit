//
//  MocktailDemoApp.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import SwiftUI

@main
struct MocktailDemoApp: App {
    
    init() {
        MocktailBootstrap.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DemoViewModel())
        }
    }
}
