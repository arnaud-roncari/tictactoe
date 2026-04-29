# Rule: Riverpod State Management

State management MUST use **Riverpod with code generation** (`@riverpod` annotation).

Run `dart run build_runner build --delete-conflicting-outputs` after any provider or notifier change.

Never use manual `StateNotifier` or `ChangeNotifier` without the `@riverpod` annotation.

GoRouter instance MUST be wrapped in a Riverpod provider (see `lib/core/router/app_router.dart`).

Document each `Notifier` with a dartdoc comment block (`///`).

## Notifiers contain no business logic

A `Notifier` is an **orchestrator**, not a logic holder. It:
- Reads state from providers (repositories, datasources)
- Calls domain use cases
- Assigns the result to `state`

**Forbidden in a Notifier:**
```dart
// ❌ business logic inside the notifier
Future<void> restart() async {
  final next = state.startingPlayer == Player.x ? Player.o : Player.x;
  final board = List<String?>.filled(9, null);
  if (next == Player.o) { ... }
}
```

**Required — delegate to a use case obtained via `ref`:**
```dart
// ✅ notifier only orchestrates — use case obtained from the provider graph
Future<void> restart() async {
  state = await ref.read(restartGameUseCaseProvider)(state);
}
```

Every distinct action (init, move, restart, persist) MUST have its own use case in `domain/usecases/`.

## Notifiers always obtain use cases via `ref`

Every use case a `Notifier` calls **must** be obtained through `ref.watch` (in `build`) or `ref.read` (in action methods). Each use case declares its own `@riverpod` provider in the same file as the class. Static `const` use cases in the notifier are forbidden.

```dart
// ❌ static use case — bypasses the provider graph
static const _makeMove = MakeMoveUseCase();
void makeMove(int index) => state = _makeMove(state, index);

// ✅ obtained via ref
void makeMove(int index) => state = ref.read(makeMoveUseCaseProvider)(state, index);
```

## Providers own dependency injection — use cases do not self-inject

A use case receives its dependencies as constructor parameters. It must **never** instantiate other use cases or services internally. Composing dependencies is the provider's responsibility.

```dart
// ❌ use case self-injects its own dependencies
RestartGameUseCase(StartingPlayerRepository repo)
    : _setStartingPlayer = SetStartingPlayerUseCase(repo),  // forbidden
      _initGame = InitGameUseCase(repo);                     // forbidden

// ✅ dependencies injected from outside — provider co-located in the same file composes them
const RestartGameUseCase(this._setStartingPlayer, this._initGame);

// At the bottom of restart_game_usecase.dart:
@riverpod
RestartGameUseCase restartGameUseCase(RestartGameUseCaseRef ref) {
  return RestartGameUseCase(
    ref.read(setStartingPlayerUseCaseProvider),
    ref.read(initGameUseCaseProvider),
  );
}
```

## Declare state and notifier as `final` at the top of `build`

In a `ConsumerWidget`, each provider MUST be retrieved **once** in a `final` variable at the top of `build`. Use `ref.watch(provider)` for state, `ref.read(provider.notifier)` for the notifier. Never repeat the same `ref.*` call within a single `build`. Declare only what the widget actually uses.

## Notifiers never call repository methods directly

A `Notifier` must **never** call repository methods (e.g. `repo.getStartingPlayer()`, `repo.setStartingPlayer(...)`) directly. Repository calls belong exclusively inside use cases.

```dart
// ❌ notifier calls repository directly
GameState build() {
  final repo = ref.watch(startingPlayerRepositoryProvider);
  return _initGame(repo.getStartingPlayer()); // forbidden
}

// ✅ use case obtained via ref — repo call is inside the use case
GameState build() => ref.watch(initGameUseCaseProvider)();
```
