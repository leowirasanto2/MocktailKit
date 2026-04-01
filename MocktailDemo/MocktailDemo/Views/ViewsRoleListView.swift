//
//  RoleListView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct RoleListView: View {
    @EnvironmentObject var model: DemoViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with action button
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Roles")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("\(model.roles.count) total")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                
                Button {
                    model.fetchRoles()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Get Roles")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [.orange, .pink],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .shadow(color: .orange.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Role Cards
            if model.roles.isEmpty {
                ContentUnavailableView {
                    Label("No Roles", systemImage: "briefcase.slash")
                } description: {
                    Text("Tap 'Get Roles' to load data")
                }
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(model.roles, id: \.roleId) { role in
                            RoleCardView(role: role)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    RoleListView()
        .environmentObject(DemoViewModel())
}
