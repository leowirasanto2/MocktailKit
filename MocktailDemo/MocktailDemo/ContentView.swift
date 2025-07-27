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
        VStack {
            ScrollView {
                Button {
                    model.fetchEmployees()
                } label: {
                    Text("Get Employees")
                }
                
                ForEach(model.employees, id: \.id) { emp in
                    HStack {
                        Image(systemName: "person.circle")
                        VStack(alignment: .leading) {
                            Text(emp.name ?? "")
                            Text("as \(model.mapRoleNameIfAvailable(of: emp.id ?? ""))")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    .padding()
                }
                
                Button {
                    model.fetchRoles()
                } label: {
                    Text("Get Roles")
                }
                
                ForEach(model.roles, id: \.roleId) { role in
                    HStack {
                        Text(role.name ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DemoViewModel())
}
