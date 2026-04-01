//
//  DemoCardView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

// Content view without button wrapper - use with NavigationLink
struct DemoCardContentView: View {
    let title: String
    let description: String
    let icon: String
    let gradientColors: [Color]
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon Container
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)
                
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            
            // Demo Info
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.title3)
                .foregroundStyle(.tertiary)
                .fontWeight(.semibold)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.background)
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
                .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(.quaternary.opacity(0.5), lineWidth: 0.5)
        )
    }
}

// Button-based card view - use for non-navigation actions
struct DemoCardView: View {
    let title: String
    let description: String
    let icon: String
    let gradientColors: [Color]
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            DemoCardContentView(
                title: title,
                description: description,
                icon: icon,
                gradientColors: gradientColors
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 16) {
        DemoCardView(
            title: "Employee Demo",
            description: "Mock API demonstration with employees and roles",
            icon: "person.2.fill",
            gradientColors: [.blue, .purple],
            action: {}
        )
        
        DemoCardView(
            title: "News Demo",
            description: "Real API with authentication token",
            icon: "newspaper.fill",
            gradientColors: [.orange, .red],
            action: {}
        )
    }
    .padding()
}
