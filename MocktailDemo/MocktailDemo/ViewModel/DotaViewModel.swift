//
//  DotaViewModel.swift
//  MocktailDemo
//

import Foundation
import Combine
import MocktailKit

final class DotaViewModel: ObservableObject {
    @Published var heroes: [DotaHero] = []
    @Published var isMockActive: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: DotaRepository
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.repository = DotaRepositoryImpl()
    }

    func fetchHeroes() {
        isLoading = true
        errorMessage = nil

        repository.fetchHeroes()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to fetch heroes: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] heroes in
                self?.heroes = heroes
            })
            .store(in: &cancellables)
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
                heroes = []
            }
        }
    }
}
