# Rule: Freezed Models

All state objects and domain entities MUST use **Freezed**.

Run `dart run build_runner build --delete-conflicting-outputs` after any model change.

Never write `copyWith`, equality, `hashCode`, or `toString` manually.

Generated `.freezed.dart` and `.g.dart` files must NOT be committed to version control (add to `.gitignore`).
