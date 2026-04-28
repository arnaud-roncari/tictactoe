# Rule: Design System

All UI values (colors, fonts, spacing, radius, padding, animation durations) MUST come from `AppDesignSystem` (`lib/core/design_system/app_design_system.dart`).

**Never hardcode** hex colors, pixel values, font sizes, or border radii in widgets.

`AppTheme` (`lib/core/design_system/app_theme.dart`) is the single source of truth for `ThemeData`. It feeds directly from `AppDesignSystem` constants.

All constants are prefixed with `k` (e.g., `kColorPrimary`, `kSpacingMD`, `kRadiusMD`).
