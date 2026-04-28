# TicTacToe — Master Specification (Betclic Technical Assessment)

## App Behavior

1. App launches on a **Home page** displaying a "Start Game" button.
2. Tapping "Start Game" navigates to the **Game page**.
3. The **player plays first** (X), then the **AI plays** (O) automatically using the Minimax algorithm.
4. The game ends when a player wins or the board is full (draw).
5. On game end, a **"Restart"** button appears.
6. If the **player wins**: winning cells are highlighted in **green**.
7. If the **AI wins**: winning cells are highlighted in **red**.
8. On **draw**: neutral state, restart button shown.

## Rules Reference

| Rule File                                          | Enforces                                            |
| -------------------------------------------------- | --------------------------------------------------- |
| [`rules/design_system.md`](rules/design_system.md) | All UI values come from `AppDesignSystem` only      |
| [`rules/architecture.md`](rules/architecture.md)   | Clean Architecture + DDD feature-oriented structure |
| [`rules/riverpod.md`](rules/riverpod.md)           | `@riverpod` annotation + build_runner mandatory     |
| [`rules/routing.md`](rules/routing.md)             | `AppRoutes` constants + GoRouter via Riverpod       |
| [`rules/freezed.md`](rules/freezed.md)             | Freezed mandatory for all models and entities       |
| [`rules/widgets.md`](rules/widgets.md)             | One widget per file, in `widgets/` folder           |
| [`rules/testing.md`](rules/testing.md)             | Unit + integration tests required per feature       |
| [`rules/code_style.md`](rules/code_style.md)       | No nested ternaries — use private helper functions  |
| [`rules/performance.md`](rules/performance.md)     | Forbidden expensive widgets (IntrinsicHeight, etc.) |

## Architecture

**Clean Architecture** with **DDD feature-oriented** structure.
Layers: `presentation → domain ← data`. Domain has zero Flutter/external dependencies.

See [`rules/architecture.md`](rules/architecture.md) for the full file structure.

## State Management

Riverpod with `@riverpod` code generation. `GameNotifier` drives all game state.
Run `dart run build_runner build --delete-conflicting-outputs` after any provider or model change.

## Routing

GoRouter exposed via a Riverpod provider. All paths declared in `AppRoutes`.

## Localization

Supported: English (`en`), French (`fr`). ARB files in `lib/core/l10n/`.
Generated via `flutter gen-l10n` (triggered by `flutter pub get` with `generate: true`).

## Design System

All colors, spacing, typography, radius, and padding are defined in `lib/core/design_system/app_design_system.dart`.
`AppTheme` in `lib/core/design_system/app_theme.dart` is the single source of truth for `ThemeData`.

## Minimax Algorithm

Located in `lib/features/game/domain/algorithms/minimax.dart`. Pure Dart — no Flutter dependencies.
Used by `MakeMoveUseCase` to compute the AI's optimal move after each player move.
