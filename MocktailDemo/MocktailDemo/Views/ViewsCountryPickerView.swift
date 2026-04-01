//
//  CountryPickerView.swift
//  MocktailDemo
//
//  Created by Leo Wirasanto Laia on 02/04/26.
//

import SwiftUI

struct CountryPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedCountry: Country
    let onSelect: (Country) -> Void
    
    @State private var searchText = ""
    
    private var recentlyUsedCountries: [Country] {
        // Always show US as recently used
        [Country.unitedStates]
    }
    
    private var allCountriesExceptRecent: [Country] {
        Country.allCountries.filter { $0.code != "us" }
    }
    
    private var filteredCountries: [Country] {
        if searchText.isEmpty {
            return allCountriesExceptRecent
        } else {
            return Country.allCountries.filter { country in
                country.name.localizedCaseInsensitiveContains(searchText) ||
                country.code.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private var shouldShowRecentSection: Bool {
        searchText.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Recently Used Section
                if shouldShowRecentSection {
                    Section {
                        ForEach(recentlyUsedCountries) { country in
                            CountryRowView(
                                country: country,
                                isSelected: selectedCountry.code == country.code,
                                action: {
                                    selectedCountry = country
                                    onSelect(country)
                                    dismiss()
                                }
                            )
                        }
                    } header: {
                        Text("Recently Used")
                    }
                }
                
                // All Countries Section
                Section {
                    ForEach(filteredCountries) { country in
                        CountryRowView(
                            country: country,
                            isSelected: selectedCountry.code == country.code,
                            action: {
                                selectedCountry = country
                                onSelect(country)
                                dismiss()
                            }
                        )
                    }
                } header: {
                    if shouldShowRecentSection {
                        Text("All Countries")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search countries")
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Country Row View
private struct CountryRowView: View {
    let country: Country
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(country.flag)
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(country.name)
                        .font(.body)
                        .foregroundStyle(.primary)
                    
                    Text(country.code.uppercased())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                        .font(.title3)
                }
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CountryPickerView(
        selectedCountry: .constant(.unitedStates),
        onSelect: { _ in }
    )
}
