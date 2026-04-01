# MocktailKit

A lightweight Swift Package that intercepts network requests and injects mock JSON responses at runtime — like Proxyman, but embedded directly in your app.

Built for iOS developers who need to work independently from backend deployments during development and debugging.

---

## Requirements

- iOS 17+
- Swift 6+
- Xcode 16+

---

## Installation

### Swift Package Manager

In Xcode, go to **File → Add Package Dependencies** and enter the repository URL.

Or add it directly to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/leowirasanto2/mocktail-kit.git", from: "1.0.0")
]
```

---

## Usage

### 1. Register routes

Map URL paths to local JSON files at app startup:

```swift
await Mocktail.shared.configure(mappings: [
    "/v1/employee/all": "employees.json",
    "/v1/role/all": "roles.json"
])
```

### 2. Serve mock data

Fetch and decode mock responses anywhere in your app:

```swift
let employees: [Employee] = try await Mocktail.shared.provide(
    from: .main,
    "/v1/employee/all",
    as: [Employee].self
)
```

### 3. Add your JSON files

Place your mock JSON files in your app bundle (e.g. inside a `MocktailJsonMaterial/` folder) and make sure they are included in the target's bundle resources.

---

## Demo

See the `MocktailDemo/` folder for a working example using the repository pattern, Combine, and SwiftUI.

---

## License

MIT
