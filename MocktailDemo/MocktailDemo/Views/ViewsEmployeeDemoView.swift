//
//  EmployeeDemoView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct EmployeeDemoView: View {
    @EnvironmentObject var model: DemoViewModel
    
    var body: some View {
        TabView {
            EmployeeListView()
                .environmentObject(model)
                .tabItem {
                    Label("Employees", systemImage: "person.2.fill")
                }
            
            RoleListView()
                .environmentObject(model)
                .tabItem {
                    Label("Roles", systemImage: "briefcase.fill")
                }
        }
        .navigationTitle("Employee Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EmployeeDemoView()
            .environmentObject(DemoViewModel())
    }
}
