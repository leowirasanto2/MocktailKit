# MocktailKit — Claude Code Guide

## Project Overview

MocktailKit is an open-source Swift Package for iOS/SwiftUI that intercepts outgoing network requests and injects mock JSON responses at runtime — similar to how Proxyman works, but embedded directly inside the app. No proxy setup, no external tooling required.

**Problem it solves:** During active development, the backend and frontend are often out of sync. MocktailKit lets iOS developers register route-to-JSON mappings so the app serves local mock data instead of hitting live endpoints — enabling frontend work to proceed independently of backend deployment state.

**Target audience:** iOS developers building SwiftUI apps who need local mock data during development or debugging.

---

## Architecture

- **`Mocktail` (actor)** — Thread-safe singleton (`Mocktail.shared`) that holds route-to-file mappings and serves mock data. Built on Swift actor for strict concurrency safety.
- **Route Registry** — Maps URL path strings (e.g. `/v1/employee/all`) to local JSON filenames (e.g. `employees.json`).
- **`MockResponseLoader`** — Static utility that reads JSON files from a given `Bundle` and returns raw `Data`.
- **`MockURLProtocol`** _(WIP)_ — `URLProtocol` subclass intended to transparently intercept `URLSession` requests and return registered mocks automatically.
- **`MockRouteRegistry`** _(WIP)_ — Extracts route info from live `URLRequest` objects for automatic matching.
- **`MocktailOverlay`** _(WIP)_ — SwiftUI debug overlay for visualizing registered routes at runtime.
- **`MockMode`** — Enum (`.disabled`, `.playback`) for toggling mock behavior; not yet wired up.

---

## Key Files

| Path | Responsibility |
|------|---------------|
| `Sources/MocktailKit/Mocktail.swift` | Main API — actor singleton, `configure`, `register`, `provide` |
| `Sources/MocktailKit/MockResponseLoader.swift` | JSON loading from bundle |
| `Sources/MocktailKit/MockURLProtocol.swift` | URLProtocol interception stub (WIP) |
| `Sources/MocktailKit/MockRouteRegistry.swift` | Automatic route resolution stub (WIP) |
| `Sources/MocktailKit/Configurations/MockConfiguration.swift` | `MockMode` enum |
| `Sources/MocktailKit/UI/MocktailOverlay.swift` | SwiftUI debug overlay (WIP) |
| `Tests/MocktailKitTests/MocktailKitTests.swift` | Unit tests |
| `MocktailDemo/` | Example iOS app showing real-world integration |

---

## Code Conventions

- **Swift 6 strict concurrency** — Use `actor` for shared mutable state. Avoid introducing classes with unprotected mutable state.
- **Async/await** — All core APIs are async. Do not introduce synchronous blocking calls.
- **No external dependencies** — The library has zero dependencies. Keep it that way.
- **Combine in demo only** — `AnyPublisher` usage is scoped to the demo app's repository layer, not the library itself.
- **`Codable` with `CodingKeys`** — Models use explicit `CodingKeys` to decouple JSON field names from Swift property names.
- **Static utility structs** — Pure functions go in static structs (e.g. `MockResponseLoader`), not free functions or singletons.

---

## Build & Test

```bash
# Build the package
swift build

# Run tests
swift test
```

The demo app lives in `MocktailDemo/` as a separate Xcode project. Open `MocktailDemo/MocktailDemo.xcodeproj` to run it.

---

## Typical Usage Pattern

```swift
// 1. Bootstrap — register routes once at app startup
await Mocktail.shared.configure(mappings: [
    "/v1/employee/all": "employees.json",
    "/v1/role/all": "roles.json"
])

// 2. Provide — fetch and decode mock data
let employees: [Employee] = try await Mocktail.shared.provide(
    from: bundle,
    "/v1/employee/all",
    as: [Employee].self
)
```

---

## WIP — Do Not Remove

The following files are intentional stubs for upcoming features. They are not functional yet but must be preserved:

- `MockURLProtocol.swift` — Future: transparent `URLSession` interception
- `MockRouteRegistry.swift` — Future: auto-match routes from live `URLRequest`
- `MocktailOverlay.swift` — Future: in-app debug overlay
- `MockConfiguration.swift` (`MockMode`) — Future: runtime toggle between `.disabled` / `.playback`

---

## Don't

> _Placeholder — add project-specific constraints here._
