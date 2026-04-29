# Rule: Imports

All imports of files inside `lib/` MUST use absolute `package:` paths.

**Forbidden:**
```dart
import '../../domain/entities/game_state.dart';
import 'app_design_system.dart';
```

**Required:**
```dart
import 'package:tic_tac_toe/features/game/domain/entities/game_state.dart';
import 'package:tic_tac_toe/core/design_system/app_design_system.dart';
```

Enforced by the `always_use_package_imports` lint in `analysis_options.yaml` (severity: `warning`). `flutter analyze` must report no issues before merging.

## Tests

Test files MUST also use absolute `package:` paths when importing from `lib/`.

**Forbidden** (in `test/`):
```dart
import '../../../../lib/features/game/domain/enums/player.dart';
```

**Required** (in `test/`):
```dart
import 'package:tic_tac_toe/features/game/domain/enums/player.dart';
```

**Exception:** imports between files that are NOT in `lib/` (e.g. test-to-test imports such as `test/.../foo_test.dart` importing from `test/mocks/`) stay relative, since `package:` paths only address files inside `lib/`.

```dart
// OK — both files live under test/, not lib/
import '../../../mocks/repositories/starting_player_repository_mock.dart';
```

