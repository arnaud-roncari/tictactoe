# Rule: Routing

All route paths MUST be declared as constants in `AppRoutes` (`lib/core/router/app_routes.dart`).

Never use raw strings for navigation — always use `AppRoutes.*` constants.

GoRouter MUST be provided via a Riverpod provider (`appRouterProvider`).

`NotFoundPage` is used as the GoRouter `errorBuilder`.
