# Rule: Testing

## Structure

Tests mirror the `lib/` DDD feature-based structure:

```
test/
├── features/
│   └── game/
│       ├── data/
│       │   └── repositories/ # Integration tests for *Impl classes using mocks
│       ├── domain/
│       │   ├── algorithms/   # Unit tests for Minimax
│       │   └── usecases/     # Unit tests for use cases
│       └── presentation/
│           ├── game_notifier_test.dart   # Notifier unit tests
│           └── game_page_test.dart       # Widget/UI tests
├── mocks/                    # Shared mock implementations
│   ├── datasources/
│   │   └── local_storage_datasource_mock.dart
│   └── repositories/
│       └── starting_player_repository_mock.dart
└── widget_test.dart          # App-level smoke test
```

## Coverage requirements

Every new feature MUST include:
- At least **1 unit test** per use case and algorithm function
- At least **1 integration test** per `*Impl` class (data layer), using mocks — not real external dependencies
- At least **1 widget test** per page
- Tests generated **alongside the feature**, not after

## Data layer tests

`*Impl` classes are tested in `test/features/<feature>/data/`. They use domain mocks (e.g. `LocalStorageDatasourceMock`) — never real external packages (e.g. `SharedPreferences`). These tests verify the impl logic (encoding, defaulting, persistence) independently of infrastructure.

## Mock naming convention

Mocks are named with the `Mock` suffix (never `Fake` or `Impl`):
```
LocalStorageDatasourceMock
StartingPlayerRepositoryMock
```

Mocks live in `test/mocks/` and implement the domain abstract class directly.
**Never use a concrete implementation** (e.g. `RepositoryImpl`) inside a test — always use a mock.

## No impl in tests

Tests must not depend on `*Impl` classes. If you need storage behavior in a test, use the corresponding mock:

```dart
// ✅ correct
startingPlayerRepositoryProvider.overrideWithValue(StartingPlayerRepositoryMock())

// ❌ forbidden
StartingPlayerRepositoryImpl(LocalStorageDatasourceImpl(prefs))
```

## Running tests

```bash
flutter test                    # all unit + widget tests
flutter test integration_test/  # integration tests (requires device)
```
