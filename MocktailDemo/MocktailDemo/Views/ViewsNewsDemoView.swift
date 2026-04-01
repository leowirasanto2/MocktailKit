//
//  NewsDemoView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct NewsDemoView: View {
    @StateObject private var model = NewsViewModel()
    @State private var showCountryPicker = false

    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Top Headlines")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("\(model.articles.count) articles loaded")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    // Active source badge
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

                // Source picker
                Picker("Source", selection: Binding(
                    get: { model.isMockActive },
                    set: { _ in model.toggleMock() }
                )) {
                    Text("Mock").tag(true)
                    Text("Live").tag(false)
                }
                .pickerStyle(.segmented)
                
                // Country selector (only visible when Live is selected)
                if !model.isMockActive {
                    Button {
                        showCountryPicker = true
                    } label: {
                        HStack {
                            Text(model.selectedCountry.flag)
                                .font(.title3)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Country")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Text(model.selectedCountry.name)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.primary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.quaternary.opacity(0.5))
                        )
                    }
                    .buttonStyle(.plain)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }

                Button {
                    model.fetchNews()
                } label: {
                    HStack {
                        if model.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Image(systemName: "arrow.clockwise")
                        }
                        Text(model.isLoading ? "Loading..." : "Get News")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: model.isMockActive ? [.purple, .indigo] : [.orange, .red],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .shadow(
                        color: (model.isMockActive ? Color.purple : Color.orange).opacity(0.3),
                        radius: 8, x: 0, y: 4
                    )
                }
                .buttonStyle(.plain)
                .disabled(model.isLoading)
                
                // Error message
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
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: model.isMockActive)

            // Content
            if model.articles.isEmpty && !model.isLoading {
                ContentUnavailableView {
                    Label("No News", systemImage: "newspaper.fill")
                } description: {
                    Text("Tap 'Get News' to load top headlines\nfrom \(model.selectedCountry.displayName)\nvia \(model.isMockActive ? "Mocktail interception" : "Live API")")
                }
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(model.articles) { article in
                            NewsCardView(article: article)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("News Demo")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerView(
                selectedCountry: $model.selectedCountry,
                onSelect: { country in
                    model.selectCountry(country)
                }
            )
        }
    }
}

#Preview {
    NavigationStack {
        NewsDemoView()
    }
}
