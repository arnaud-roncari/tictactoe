# TicTacToe — Betclic Technical Assessment

Flutter TicTacToe avec une IA imbattable basée sur l'algorithme Minimax.

---

## Lancer le projet

```bash
# 1. Installer les dépendances
flutter pub get

# 2. Générer le code (Riverpod providers, Freezed models)
dart run build_runner build --delete-conflicting-outputs

# 3. Lancer l'application
flutter run
```

> Les localisations (`app_localizations.dart`) sont générées automatiquement par `flutter pub get` via `flutter gen-l10n` — aucune action supplémentaire requise.

### Tests

```bash
# Tests unitaires et widget
flutter test

# Tests d'intégration (appareil connecté ou émulateur requis)
flutter test integration_test/
```

---

## Architecture — Clean Architecture + DDD

Le projet suit une **Clean Architecture** avec une organisation des fichiers orientée **DDD (Domain-Driven Design)** par feature.

### Principe de dépendance

```
presentation → domain ← data
```

Les dépendances ne peuvent pointer que vers le domaine. Le domaine ne connaît ni la couche data, ni la couche presentation.

### Les trois couches

**Domain** — cœur métier, Dart pur. Aucune dépendance Flutter ou externe. Contient :

- les entités (`GameState` avec Freezed)
- les enums (`Player`, `GameStatus`)
- les interfaces abstraites (`StartingPlayerRepository`, `LocalStorageDatasource`)
- les use cases (`InitGameUseCase`, `MakeMoveUseCase`, `RestartGameUseCase`, `SetStartingPlayerUseCase`)
- l'algorithme Minimax

**Data** — implémente les contrats du domaine. Contient les classes `_impl` qui réalisent les interfaces abstraites. Déclare ses propres providers Riverpod.

**Presentation** — widgets, pages, notifiers. `GameNotifier` ne contient aucune logique métier : il délègue entièrement aux use cases via `ref`.

### Structure des fichiers

```
lib/
├── core/
│   ├── constants/
│   ├── design_system/
│   ├── router/
│   ├── observer/
│   └── l10n/
└── features/
    ├── home/
    │   └── presentation/
    │       ├── pages/
    │       └── widgets/
    ├── game/
    │   ├── data/
    │   │   ├── datasources/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── algorithms/
    │   │   ├── datasources/
    │   │   ├── entities/
    │   │   ├── enums/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── notifiers/
    │       ├── pages/
    │       └── widgets/
    └── not_found/
        └── presentation/
            └── pages/
```
