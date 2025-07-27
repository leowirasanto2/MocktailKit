import Foundation
import Combine
import MocktailKit

enum OfficeAPI: Equatable {
    case getEmployees
    case getRoles

    var url: String {
        switch self {
        case .getEmployees:
            return "/v1/employee/all"
        case .getRoles:
            return "/v1/role/all"
        }
    }

    var method: String {
        switch self {
        case .getEmployees, .getRoles:
            return "GET"
        }
    }
}

protocol OfficeRepository {
    func fetchEmployees() -> AnyPublisher<[Employee], Error>
    func fetchRoles() -> AnyPublisher<[Role], Error>
}

class OfficeRepositoryImpl: OfficeRepository {
    func fetchEmployees() -> AnyPublisher<[Employee], Error> {
        Future { promise in
            Task {
                do {
                    let result = try await Mocktail.shared.provide(from: .main, OfficeAPI.getEmployees.url, as: [Employee].self)
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchRoles() -> AnyPublisher<[Role], Error> {
        Future { promise in
            Task {
                do {
                    let result = try await Mocktail.shared.provide(from: .main, OfficeAPI.getRoles.url, as: [Role].self)
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
