# Rule: Code Style

## No nested ternaries

Never chain ternaries inside ternaries. Extract logic into small private functions instead.

**Forbidden:**
```dart
final color = isWinning
    ? (gameStatus == GameStatus.playerWin ? kColorPlayerWin : kColorAiWin)
    : null;
```

**Required:**
```dart
Color _backgroundColor() {
  if (!isWinning) return kColorSurface;
  if (gameStatus == GameStatus.playerWin) return kColorPlayerWin;
  return kColorAiWin;
}
```

Private helper functions must be prefixed with `_` and named after what they return (`_backgroundColor`, `_textColor`, `_cellContent`). Each function handles one decision, one level of logic.
