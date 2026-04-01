//
//  DemoListView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct DemoListView: View {
    @State private var selectedDemo: DemoType?
    
    enum DemoType: Identifiable {
        case employee
        case news
        
        var id: String {
            switch self {
            case .employee: return "employee"
            case .news: return "news"
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Mocktail Demo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Explore different API mocking scenarios")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    
                    // Demo Cards
                    VStack(spacing: 16) {
                        // Employee Demo
                        NavigationLink(value: DemoType.employee) {
                            DemoCardContentView(
                                title: "Employee Demo",
                                description: "Mock API demonstration with employees and roles",
                                icon: "person.2.fill",
                                gradientColors: [.blue, .purple]
                            )
                        }
                        .buttonStyle(.plain)
                        
                        // News Demo
                        NavigationLink(value: DemoType.news) {
                            DemoCardContentView(
                                title: "News Demo",
                                description: "Real API with authentication token",
                                icon: "newspaper.fill",
                                gradientColors: [.orange, .red]
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    
                    // Info Section
                    VStack(alignment: .leading, spacing: 12) {
                        Label("About Mocktail", systemImage: "info.circle.fill")
                            .font(.headline)
                            .foregroundStyle(.blue)
                        
                        Text("Mocktail allows you to mock network requests for testing and development. Each demo showcases different use cases and capabilities.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.blue.opacity(0.1))
                    )
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationDestination(for: DemoType.self) { demoType in
                switch demoType {
                case .employee:
                    EmployeeDemoView()
                case .news:
                    NewsDemoView()
                }
            }
        }
    }
}

#Preview {
    DemoListView()
        .environmentObject(DemoViewModel())
}
