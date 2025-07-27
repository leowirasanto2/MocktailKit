//
//  DemoViewModel.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation
import Combine

final class DemoViewModel: ObservableObject {
    @Published var employees: [Employee] = []
    @Published var roles: [Role] = []

    private let repository: OfficeRepository
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.repository = OfficeRepositoryImpl()
    }

    func fetchEmployees() {
        repository.fetchEmployees()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch employees: \(error)")
                }
            }, receiveValue: { [weak self] employees in
                self?.employees = employees
            })
            .store(in: &cancellables)
    }

    func fetchRoles() {
        repository.fetchRoles()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch roles: \(error)")
                }
            }, receiveValue: { [weak self] roles in
                self?.roles = roles
            })
            .store(in: &cancellables)
    }

    func mapRoleNameIfAvailable(of employeeId: String) -> String {
        // Find the employee by ID
        guard let employee = employees.first(where: { $0.id == employeeId }),
              let roleId = employee.roleId else {
            return "Unknown Role"
        }
        
        // Find the role by roleId and return its name
        guard let role = roles.first(where: { $0.roleId == roleId }),
              let roleName = role.name else {
            return "Role's not loaded"
        }
        
        return roleName
    }
}
