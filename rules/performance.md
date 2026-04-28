# Rule: Performance — Forbidden Widgets

The following widgets trigger expensive layout or paint passes and are **forbidden** unless explicitly justified with a comment explaining why there is no alternative.

## Layout

| Forbidden | Why | Alternative |
|---|---|---|
| `IntrinsicHeight` | Forces a double layout pass on all children | Use `Expanded`, `CrossAxisAlignment`, or fixed sizes |
| `IntrinsicWidth` | Same as above | Use `Expanded` or constrain parent |
| `Wrap` (with many children) | Recomputes layout for every child on each pass | Use `GridView.builder` or `Flex` |

## Paint

| Forbidden | Why | Alternative |
|---|---|---|
| `Opacity` | Promotes subtree to its own layer, triggers `saveLayer` | Use `Color.withOpacity()` directly on the color, or `AnimatedOpacity` only when animating |
| `BackdropFilter` | Extremely expensive, blurs everything behind | Avoid entirely or scope to the smallest possible widget |
| `Offstage` | Keeps the full widget tree alive and laid out even when hidden | Use conditional rendering (`if (visible) Widget()`) |
| `ClipPath` with complex paths | Recomputes clip on every frame | Prefer `ClipRRect` with simple radii or `DecoratedBox` |

## Lists

| Forbidden | Why | Alternative |
|---|---|---|
| `ListView(children: [...])` | Builds all children eagerly | Always use `ListView.builder` or `GridView.builder` |
| `Column` inside a `SingleChildScrollView` with many children | No virtualization | Use `ListView.builder` |

## Verification

Run the following to check for violations before any PR:
```bash
grep -rn "IntrinsicHeight\|IntrinsicWidth\|Offstage\|BackdropFilter\|ListView(" lib/
```
