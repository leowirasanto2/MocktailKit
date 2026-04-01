//
//  NewsViewModel.swift
//  MocktailDemo
//

import Foundation
import Combine
import MocktailKit

final class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isMockActive: Bool = true
    @Published var selectedCountry: Country = .unitedStates
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: NewsRepository
    private var cancellables = Set<AnyCancellable>()
    
    /// Cache for storing articles by country and source (mock/live)
    /// Format: "{countryCode}_{mock/live}" (e.g., "us_mock", "gb_live")
    private var cache: [String: [Article]] = [:]
    
    private func cacheKey(country: String, isMock: Bool) -> String {
        "\(country)_\(isMock ? "mock" : "live")"
    }

    init() {
        self.repository = NewsRepositoryImpl()
    }

    func fetchNews() {
        let key = cacheKey(country: selectedCountry.code, isMock: isMockActive)
        
        // Check cache first
        if let cachedArticles = cache[key], !cachedArticles.isEmpty {
            articles = cachedArticles
            return
        }
        
        // Fetch from network
        isLoading = true
        errorMessage = nil
        
        repository.fetchTopHeadlines(country: selectedCountry.code)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to fetch news: \(error.localizedDescription)"
                    print("Failed to fetch news: \(error)")
                }
            }, receiveValue: { [weak self] articles in
                guard let self = self else { return }
                self.articles = articles
                // Cache the results
                self.cache[key] = articles
            })
            .store(in: &cancellables)
    }
    
    func loadCachedArticles() {
        let key = cacheKey(country: selectedCountry.code, isMock: isMockActive)
        if let cachedArticles = cache[key] {
            articles = cachedArticles
        }
    }

    func toggleMock() {
        Task {
            if isMockActive {
                await Mocktail.shared.deactivateInterception()
            } else {
                await Mocktail.shared.activateInterception()
            }
            await MainActor.run {
                isMockActive.toggle()
                // Load cached data for the current configuration if available
                loadCachedArticles()
            }
        }
    }
    
    func selectCountry(_ country: Country) {
        selectedCountry = country
        // Load cached data for the new country if available
        loadCachedArticles()
    }
}
