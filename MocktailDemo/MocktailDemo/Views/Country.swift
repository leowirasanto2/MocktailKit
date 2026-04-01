//
//  Country.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import Foundation

struct Country: Identifiable, Hashable {
    let code: String
    let name: String
    let flag: String
    
    var id: String { code }
    
    var displayName: String {
        "\(flag) \(name)"
    }
}

extension Country {
    /// Countries supported by News API top-headlines endpoint
    /// Uses ISO 3166-1 alpha-2 codes (2-letter country codes)
    /// Note: Availability may vary based on API key tier/plan
    static let allCountries: [Country] = [
        Country(code: "ae", name: "United Arab Emirates", flag: "🇦🇪"),
        Country(code: "ar", name: "Argentina", flag: "🇦🇷"),
        Country(code: "at", name: "Austria", flag: "🇦🇹"),
        Country(code: "au", name: "Australia", flag: "🇦🇺"),
        Country(code: "be", name: "Belgium", flag: "🇧🇪"),
        Country(code: "bg", name: "Bulgaria", flag: "🇧🇬"),
        Country(code: "br", name: "Brazil", flag: "🇧🇷"),
        Country(code: "ca", name: "Canada", flag: "🇨🇦"),
        Country(code: "ch", name: "Switzerland", flag: "🇨🇭"),
        Country(code: "cn", name: "China", flag: "🇨🇳"),
        Country(code: "co", name: "Colombia", flag: "🇨🇴"),
        Country(code: "cu", name: "Cuba", flag: "🇨🇺"),
        Country(code: "cz", name: "Czech Republic", flag: "🇨🇿"),
        Country(code: "de", name: "Germany", flag: "🇩🇪"),
        Country(code: "eg", name: "Egypt", flag: "🇪🇬"),
        Country(code: "fr", name: "France", flag: "🇫🇷"),
        Country(code: "gb", name: "United Kingdom", flag: "🇬🇧"),
        Country(code: "gr", name: "Greece", flag: "🇬🇷"),
        Country(code: "hk", name: "Hong Kong", flag: "🇭🇰"),
        Country(code: "hu", name: "Hungary", flag: "🇭🇺"),
        Country(code: "id", name: "Indonesia", flag: "🇮🇩"),
        Country(code: "ie", name: "Ireland", flag: "🇮🇪"),
        Country(code: "il", name: "Israel", flag: "🇮🇱"),
        Country(code: "in", name: "India", flag: "🇮🇳"),
        Country(code: "it", name: "Italy", flag: "🇮🇹"),
        Country(code: "jp", name: "Japan", flag: "🇯🇵"),
        Country(code: "kr", name: "South Korea", flag: "🇰🇷"),
        Country(code: "lt", name: "Lithuania", flag: "🇱🇹"),
        Country(code: "lv", name: "Latvia", flag: "🇱🇻"),
        Country(code: "ma", name: "Morocco", flag: "🇲🇦"),
        Country(code: "mx", name: "Mexico", flag: "🇲🇽"),
        Country(code: "my", name: "Malaysia", flag: "🇲🇾"),
        Country(code: "ng", name: "Nigeria", flag: "🇳🇬"),
        Country(code: "nl", name: "Netherlands", flag: "🇳🇱"),
        Country(code: "no", name: "Norway", flag: "🇳🇴"),
        Country(code: "nz", name: "New Zealand", flag: "🇳🇿"),
        Country(code: "ph", name: "Philippines", flag: "🇵🇭"),
        Country(code: "pl", name: "Poland", flag: "🇵🇱"),
        Country(code: "pt", name: "Portugal", flag: "🇵🇹"),
        Country(code: "ro", name: "Romania", flag: "🇷🇴"),
        Country(code: "rs", name: "Serbia", flag: "🇷🇸"),
        Country(code: "ru", name: "Russia", flag: "🇷🇺"),
        Country(code: "sa", name: "Saudi Arabia", flag: "🇸🇦"),
        Country(code: "se", name: "Sweden", flag: "🇸🇪"),
        Country(code: "sg", name: "Singapore", flag: "🇸🇬"),
        Country(code: "si", name: "Slovenia", flag: "🇸🇮"),
        Country(code: "sk", name: "Slovakia", flag: "🇸🇰"),
        Country(code: "th", name: "Thailand", flag: "🇹🇭"),
        Country(code: "tr", name: "Turkey", flag: "🇹🇷"),
        Country(code: "tw", name: "Taiwan", flag: "🇹🇼"),
        Country(code: "ua", name: "Ukraine", flag: "🇺🇦"),
        Country(code: "us", name: "United States", flag: "🇺🇸"),
        Country(code: "ve", name: "Venezuela", flag: "🇻🇪"),
        Country(code: "za", name: "South Africa", flag: "🇿🇦")
    ]
    
    static let unitedStates = allCountries.first { $0.code == "us" }!
}
