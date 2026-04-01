//
//  EmployeeCardView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct EmployeeCardView: View {
    let employee: Employee
    let roleName: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Profile Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                
                Image(systemName: "person.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            // Employee Info
            VStack(alignment: .leading, spacing: 6) {
                Text(employee.name ?? "Unknown")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                HStack(spacing: 4) {
                    Image(systemName: "briefcase.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(roleName.isEmpty ? "No Role" : roleName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                if let employeeId = employee.id, !employeeId.isEmpty {
                    Text("ID: \(employeeId)")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Chevron indicator
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

#Preview("Single Employee") {
    EmployeeCardView(
        employee: Employee(name: "John Doe", id: "EMP001", roleId: "ROLE123"),
        roleName: "Software Engineer"
    )
    .padding()
}

#Preview("Employee List") {
    ScrollView {
        VStack(spacing: 12) {
            EmployeeCardView(
                employee: Employee(name: "Jane Smith", id: "EMP002", roleId: "ROLE456"),
                roleName: "Product Manager"
            )
            
            EmployeeCardView(
                employee: Employee(name: "Mike Johnson", id: "EMP003", roleId: "ROLE789"),
                roleName: "UI/UX Designer"
            )
            
            EmployeeCardView(
                employee: Employee(name: "Sarah Williams", id: "EMP004", roleId: "ROLE012"),
                roleName: "Team Lead"
            )
        }
        .padding()
    }
}
