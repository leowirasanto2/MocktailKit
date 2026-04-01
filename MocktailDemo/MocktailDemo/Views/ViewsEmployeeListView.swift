//
//  EmployeeListView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct EmployeeListView: View {
    @EnvironmentObject var model: DemoViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with action button
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Employees")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("\(model.employees.count) total")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                
                Button {
                    model.fetchEmployees()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Get Employees")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Employee Cards
            if model.employees.isEmpty {
                ContentUnavailableView {
                    Label("No Employees", systemImage: "person.2.slash")
                } description: {
                    Text("Tap 'Get Employees' to load data")
                }
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(model.employees, id: \.id) { emp in
                            EmployeeCardView(
                                employee: emp,
                                roleName: model.mapRoleNameIfAvailable(of: emp.id ?? "")
                            )
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
    EmployeeListView()
        .environmentObject(DemoViewModel())
}
