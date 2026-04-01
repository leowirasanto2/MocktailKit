# MocktailKit — Claude Code Guide

## Project Overview

MocktailKit is an open-source Swift Package for iOS/SwiftUI that intercepts outgoing network requests and injects mock JSON responses at runtime — similar to how Proxyman works, but embedded directly inside the app. No proxy setup, no external tooling required.

**Problem it solves:** During active development, the backend and frontend are often out of sync. MocktailKit lets iOS developers register route-to-JSON mappings so the app serves local mock data instead of hitting live endpoints — enabling frontend work to proceed independently of backend deployment state.

**Target audience:** iOS developers building SwiftUI apps who need local mock data during development or debugging.

---

## Architecture

- **`Mocktail` (actor)** — Thread-safe singleton (`Mocktail.shared`) that holds route-to-file mappings and serves mock data. Built on Swift actor for strict concurrency safety. Also owns `activateInterception()` / `deactivateInterception()` to register/unregister `MockURLProtocol`.
- **Route Registry** — Maps URL path strings (e.g. `/v1/employee/all`) to local JSON filenames (e.g. `employees.json`).
- **`MockResponseLoader`** — Static utility that reads JSON files from a given `Bundle` and returns raw `Data`.
- **`MockURLProtocol`** — `URLProtocol` subclass that transparently intercepts `URLSession` requests. Registered paths return local mock JSON; unregistered paths pass through to the real server. Uses a semaphore + `MockDataBox` pattern to bridge async actor access into the synchronous `URLProtocol` API.
- **`MockRouteRegistry`** _(WIP)_ — Extracts route info from live `URLRequest` objects for automatic matching.
- **`MocktailOverlay`** _(WIP)_ — SwiftUI debug overlay for visualizing registered routes at runtime.
- **`MockMode`** — Enum (`.disabled`, `.playback`) for toggling mock behavior; not yet wired up.

---

## Key Files

| Path | Responsibility |
|------|---------------|
| `Sources/MocktailKit/Mocktail.swift` | Main API — actor singleton, `configure`, `register`, `provide`, `activateInterception`, `deactivateInterception` |
| `Sources/MocktailKit/MockResponseLoader.swift` | JSON loading from bundle |
| `Sources/MocktailKit/MockURLProtocol.swift` | URLProtocol interception — mocks registered paths, passes through everything else |
| `Sources/MocktailKit/MockRouteRegistry.swift` | Automatic route resolution stub (WIP) |
| `Sources/MocktailKit/Configurations/MockConfiguration.swift` | `MockMode` enum |
| `Sources/MocktailKit/UI/MocktailOverlay.swift` | SwiftUI debug overlay (WIP) |
| `Tests/MocktailKitTests/MocktailKitTests.swift` | Unit tests |
| `MocktailDemo/` | Example iOS app showing real-world integration |
| `MocktailKit.xcworkspace` | Root workspace — open this instead of the individual `.xcodeproj` or `Package.swift` |

---

## Code Conventions

- **Swift 6 strict concurrency** — Use `actor` for shared mutable state. Avoid introducing classes with unprotected mutable state.
- **Async/await** — All core APIs are async. Do not introduce synchronous blocking calls.
- **No external dependencies** — The library has zero dependencies. Keep it that way.
- **Combine in demo only** — `AnyPublisher` usage is scoped to the demo app's repository layer, not the library itself.
- **`Codable` with `CodingKeys`** — Models use explicit `CodingKeys` to decouple JSON field names from Swift property names.
- **Static utility structs** — Pure functions go in static structs (e.g. `MockResponseLoader`), not free functions or singletons.
- **`@unchecked Sendable`** — Used only where semaphore-based ordering guarantees safety (e.g. `MockDataBox` in `MockURLProtocol`). Always comment the invariant.

---

## Build & Test

```bash
# Build the package
swift build

# Run tests
swift test
```

Open `MocktailKit.xcworkspace` (root) to work on both the library and demo in one place. Select the `MocktailDemo` scheme when editing demo files to enable SwiftUI Previews.

---

## Typical Usage Pattern

### Option A — Manual provide (no URLSession interception)

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

### Option B — Transparent URLSession interception (recommended)

```swift
// 1. Bootstrap — register routes and activate interception
await Mocktail.shared.configure(mappings: [
    "/v2/top-headlines": "top-news-mock.json"
])
await Mocktail.shared.activateInterception()

// 2. Make normal URLSession requests — MockURLProtocol intercepts registered paths automatically
let (data, _) = try await URLSession.shared.data(from: URL(string: "https://newsapi.org/v2/top-headlines")!)

// 3. Deactivate when done (e.g. switching to Live mode)
await Mocktail.shared.deactivateInterception()
```

---

## WIP — Do Not Remove

The following files are intentional stubs for upcoming features. They are not functional yet but must be preserved:

- `MockRouteRegistry.swift` — Future: auto-match routes from live `URLRequest`
- `MocktailOverlay.swift` — Future: in-app debug overlay
- `MockConfiguration.swift` (`MockMode`) — Future: runtime toggle between `.disabled` / `.playback`

---

## Don't

- Don't hardcode real API keys in library code. The demo uses a NewsAPI key for illustration only — do not replicate this pattern in the library itself.
- Don't call `DispatchSemaphore.wait()` on the main thread — only safe on URLProtocol's background loading thread.
- Don't register `MockURLProtocol` in production builds — it is intended for development and debugging only.
