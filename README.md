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

### 2. Add your JSON files

Place your mock JSON files in your app bundle (e.g. inside a `MocktailJsonMaterial/` folder) and make sure they are included in the target's bundle resources.

---

## Interception Modes

### Option A — Manual `provide`

Explicitly fetch and decode mock data by route:

```swift
let employees: [Employee] = try await Mocktail.shared.provide(
    from: .main,
    "/v1/employee/all",
    as: [Employee].self
)
```

### Option B — Transparent URLSession interception ✨

Activate interception once at startup and let `MockURLProtocol` handle the rest. Your existing `URLSession` code requires **zero changes** — registered paths return mock JSON automatically, everything else passes through to the real server.

```swift
// At app startup
await Mocktail.shared.configure(mappings: [
    "/v2/top-headlines": "top-news-mock.json"
])
await Mocktail.shared.activateInterception()

// Your normal URLSession call — no changes needed
let (data, _) = try await URLSession.shared.data(from: newsURL)
// ↑ MockURLProtocol intercepts this and returns top-news-mock.json
```

Toggle mock on/off at runtime:

```swift
// Switch to live
await Mocktail.shared.deactivateInterception()

// Switch back to mock
await Mocktail.shared.activateInterception()
```

---

## Demo

The `MocktailDemo/` app demonstrates both patterns side-by-side:

- **Employee / Role demo** — uses `Mocktail.shared.provide()` (Option A)
- **News demo** — uses transparent URLSession interception (Option B) with a live toggle between Mocktail and the real NewsAPI

Open `MocktailKit.xcworkspace` at the repo root to run both the library and demo from a single Xcode window.

---

## License

MIT
