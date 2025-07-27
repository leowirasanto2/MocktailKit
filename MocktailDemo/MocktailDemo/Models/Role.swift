//
//  Roles.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 28/07/25.
//

import Foundation

struct Role: Codable {
    var roleId: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case roleId = "role_id"
        case name
    }
}
