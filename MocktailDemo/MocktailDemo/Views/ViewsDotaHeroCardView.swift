//
//  DotaHeroCardView.swift
//  MocktailDemo
//

import SwiftUI

struct DotaHeroCardView: View {
    let hero: DotaHero

    private var attrColor: Color {
        switch hero.primaryAttr {
        case "str": return .red
        case "agi": return .green
        case "int": return .blue
        case "all": return .purple
        default: return .gray
        }
    }

    private var attrLabel: String {
        switch hero.primaryAttr {
        case "str": return "STR"
        case "agi": return "AGI"
        case "int": return "INT"
        case "all": return "UNI"
        default: return "?"
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            // Attr badge
            Text(attrLabel)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(Circle().fill(attrColor))

            VStack(alignment: .leading, spacing: 4) {
                Text(hero.localizedName ?? hero.name ?? "Unknown")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                if let roles = hero.roles, !roles.isEmpty {
                    Text(roles.joined(separator: " · "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer()

            Label(hero.attackType ?? "", systemImage: hero.attackType == "Melee" ? "sword" : "arrow.up.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.quaternary.opacity(0.4))
        )
    }
}
