# Rule: Clean Architecture + DDD

Respect Clean Architecture layers: `presentation → domain ← data`.

- **Domain** must have no Flutter dependencies — pure Dart only. `riverpod_annotation` is allowed (pure Dart package) to co-locate provider declarations with their class.
- **Presentation** depends on domain (entities, use cases, enums, providers).
- **Data** implements domain contracts (repositories, datasources).

## Abstract / Implementation convention

Every external dependency (storage, network, device APIs) follows the same pattern:

| What | Where | Rule |
|---|---|---|
| Abstract datasource | `domain/datasources/` | Pure Dart interface, no implementation detail |
| Abstract repository | `domain/repositories/` | Pure Dart interface, no implementation detail |
| Use case + provider | `domain/usecases/` | Class + `@riverpod` declaration co-located in the same file |
| Datasource impl + provider | `data/datasources/` | Implements domain interface; provider returns the abstract type and throws — must be overridden |
| Repository impl + provider | `data/repositories/` | Implements domain interface; provider returns the abstract type and auto-wires from the datasource provider |

Providers are declared **in the same file as their class**. There are no standalone provider files.

`main.dart` is the **composition root**: it overrides only `localStorageDatasourceProvider` with a `LocalStorageDatasourceImpl(prefs)`. The repository provider auto-wires itself from the datasource provider.

**The domain never imports from data.** Exception: use case provider functions (co-located at the bottom of use case files) may import from `data/repositories/` to read the repository provider. Use case classes themselves must not import from `data/`.

**Presentation imports only from `domain/`.** It must not reference `_impl` classes or any file under `data/`.

**Data never imports from presentation.**

```
domain/repositories/starting_player_repository.dart   ← abstract class + provider (throws)
data/repositories/starting_player_repository_impl.dart ← implements it

domain/datasources/local_storage_datasource.dart       ← abstract class + provider (throws)
data/datasources/local_storage_datasource_impl.dart    ← implements it
```

Global constants (e.g. storage keys) live in `core/constants/` — never hardcoded inline.

## File structure

```
lib/
├── core/
│   ├── constants/        # StorageKeys and other global constants
│   ├── design_system/
│   ├── router/
│   ├── observer/
│   └── l10n/
└── features/
    ├── home/presentation/
    ├── game/
    │   ├── data/
    │   │   ├── datasources/  # Implementations only
    │   │   └── repositories/ # Implementations only
    │   ├── domain/
    │   │   ├── algorithms/   # Minimax — pure Dart, no Flutter deps
    │   │   ├── datasources/  # Abstract interface + provider declaration
    │   │   ├── entities/
    │   │   ├── enums/
    │   │   ├── repositories/ # Abstract interface + provider declaration
    │   │   └── usecases/     # Use case class + provider declaration
    │   └── presentation/
    │       ├── notifiers/
    │       └── widgets/
    └── not_found/presentation/
```

No cross-feature imports except through domain contracts.
