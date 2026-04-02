//
//  DotaHero.swift
//  MocktailDemo
//

import Foundation

struct DotaHero: Codable, Identifiable {
    var id: Int
    var name: String?
    var localizedName: String?
    var primaryAttr: String?
    var attackType: String?
    var roles: [String]?
    var legs: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles
        case legs
    }
}
