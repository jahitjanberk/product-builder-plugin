---
type: llm
weight: 2
---
PASS only if ALL of these hold:
1. The design covers at least three non-happy-path states for the order list: an empty state (no orders yet), a loading state, and an error state with a recovery action (e.g. retry).
2. It includes at least one concrete accessibility requirement: a contrast ratio target, visible focus, a minimum touch-target size, or not relying on colour alone for order status.
3. It names a visual direction or style, with a reason tied to the audience or product.
FAIL otherwise.
