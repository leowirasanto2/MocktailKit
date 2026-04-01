//
//  ContentView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: DemoViewModel
    
    var body: some View {
        DemoListView()
            .environmentObject(model)
    }
}

#Preview {
    ContentView()
        .environmentObject(DemoViewModel())
}
