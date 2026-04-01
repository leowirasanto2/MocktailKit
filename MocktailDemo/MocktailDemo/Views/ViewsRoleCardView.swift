//
//  RoleCardView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct RoleCardView: View {
    let role: Role
    
    var body: some View {
        HStack(spacing: 16) {
            // Role Icon
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [.orange.opacity(0.6), .pink.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                
                Image(systemName: "briefcase.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            // Role Info
            VStack(alignment: .leading, spacing: 6) {
                Text(role.name ?? "Unknown Role")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                if let roleId = role.roleId, !roleId.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "number")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text(roleId)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Badge indicator
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
                .fontWeight(.semibold)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.background)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                .shadow(color: .black.opacity(0.03), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.quaternary.opacity(0.5), lineWidth: 0.5)
        )
    }
}

#Preview("Single Role") {
    RoleCardView(
        role: Role(roleId: "ROLE123", name: "Software Engineer")
    )
    .padding()
}

#Preview("Role List") {
    ScrollView {
        VStack(spacing: 12) {
            RoleCardView(
                role: Role(roleId: "ROLE001", name: "Software Engineer")
            )
            
            RoleCardView(
                role: Role(roleId: "ROLE002", name: "Product Manager")
            )
            
            RoleCardView(
                role: Role(roleId: "ROLE003", name: "UI/UX Designer")
            )
        }
        .padding()
    }
}
