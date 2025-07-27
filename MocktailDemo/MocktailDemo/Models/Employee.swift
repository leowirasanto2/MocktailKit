//
//  Employee.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation

struct Employee: Codable {
    var name: String?
    var id: String?
    var roleId: String?

    enum CodingKeys: String, CodingKey {
        case name
        case id = "employee_id"
        case roleId = "role_id"
    }
}
