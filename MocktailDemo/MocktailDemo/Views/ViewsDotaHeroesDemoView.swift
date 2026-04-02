//
//  DotaHeroesDemoView.swift
//  MocktailDemo
//

import SwiftUI

struct DotaHeroesDemoView: View {
    @StateObject private var model = DotaViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Dota 2 Heroes")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("\(model.heroes.count) heroes loaded")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Label(
                        model.isMockActive ? "Mocktail" : "Live API",
                        systemImage: model.isMockActive ? "server.rack" : "antenna.radiowaves.left.and.right"
                    )
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(model.isMockActive ? .purple : .green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(model.isMockActive ? Color.purple.opacity(0.1) : Color.green.opacity(0.1))
                    )
                }

                Picker("Source", selection: Binding(
                    get: { model.isMockActive },
                    set: { _ in model.toggleMock() }
                )) {
                    Text("Mock").tag(true)
                    Text("Live").tag(false)
                }
                .pickerStyle(.segmented)

                Button {
                    model.fetchHeroes()
                } label: {
                    HStack {
                        if model.isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Image(systemName: "arrow.clockwise")
                        }
                        Text(model.isLoading ? "Loading..." : "Get Heroes")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: model.isMockActive ? [.purple, .indigo] : [.teal, .green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .shadow(
                        color: (model.isMockActive ? Color.purple : Color.teal).opacity(0.3),
                        radius: 8, x: 0, y: 4
                    )
                }
                .buttonStyle(.plain)
                .disabled(model.isLoading)

                if let errorMessage = model.errorMessage {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.orange.opacity(0.1))
                    )
                }
            }
            .padding(.horizontal)
            .padding(.top)

            if model.heroes.isEmpty && !model.isLoading {
                ContentUnavailableView {
                    Label("No Heroes", systemImage: "shield.fill")
                } description: {
                    Text("Tap 'Get Heroes' to load Dota 2 heroes\nvia \(model.isMockActive ? "Mocktail interception" : "Live API")")
                }
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(model.heroes) { hero in
                            DotaHeroCardView(hero: hero)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("Dota Heroes Demo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DotaHeroesDemoView()
    }
}
