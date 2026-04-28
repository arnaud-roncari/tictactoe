# Rule: Widget Files

Each widget MUST live in its own dedicated file.

**One widget per file — no exceptions.**

No widget may be declared inside a page file or alongside another widget.

Widgets live in the `widgets/` folder of their feature's `presentation/` layer:
```
features/<feature>/presentation/widgets/<widget_name>_widget.dart
```
