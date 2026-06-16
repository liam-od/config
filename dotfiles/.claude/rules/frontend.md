---
paths:
  - "**/*.tsx"
  - "**/*.ts"
  - "**/*.vue"
  - "**/*.svelte"
---

# Frontend Rules

## TypeScript

- Never use `any`; use `unknown` for truly unknown types and narrow with guards
- Annotate props, function parameters, and return values explicitly — don't lean on inference for
  public surfaces
- Keep shared types in a co-located `types.ts`; don't scatter inline type declarations across
  components

## File size and decomposition

- Aim for **~300 lines** per file — a soft guideline in service of separation of concerns, not a
  cap. Split at a logical seam; a longer file with no clean split is fine. Don't pad or contort code
  to hit a number
- One exported component per file; extract sub-components once they exceed ~50 lines
- Extract complex render logic (conditionals, derived values, lists) to named variables or helper
  components above the return — don't inline it in JSX/template

## Single Responsibility

- Each component does one UI thing and has one reason to change
- Keep stateful logic, data fetching, and side effects out of components — they belong in the
  framework's logic layer (React hook, Vue composable, Svelte `*.svelte.ts`). The component does
  markup, layout, and event wiring; a component that fetches data should delegate the fetch
- Pure transformations go in utils (no state, no side effects); HTTP calls and response mapping go
  in a dedicated API client

## Components

- PascalCase component, filename to match (`UserCard.tsx`, `UserCard.svelte`); one component per file
- Type props explicitly: a named interface in React/Vue, an inline type on `$props()` in Svelte
- Avoid prop drilling beyond two levels; lift to context or a shared store instead
- Prefer composition over configuration — compose small focused components rather than adding
  boolean flags that significantly change behaviour

## Vue Composition API

- Always `<script setup lang="ts">` — no Options API, no `defineComponent` wrapper
- Props via `defineProps<{ ... }>()`; keep `<script setup>` to wiring and move complex logic into a
  composable (`use*.ts`)

## Svelte 5 (runes)

- Use runes with `<script lang="ts">` — don't fall back to Svelte 4: no `export let`, no `$:`, no
  `<slot>`, no `on:click`, no writable stores. Props are `let { ... }: { ... } = $props()` with an
  inline type and defaults; children are snippets (`{@render children()}`); DOM handlers are
  lowercase attributes (`onclick`)
- Reactive logic that outlives a component (state machines, capture/teardown, shared context) lives
  in a `*.svelte.ts` module — a `$state`-backed class or a `provide*`/`use*` context pair — so the
  component stays markup + wiring

## Comments and documentation

- **JSDoc** (`/** */`): on exported functions, hooks, and components; describe *purpose* and
  non-obvious parameters — not implementation steps
- **Inline comments** (`//`): only for genuinely non-obvious one-liners, explaining *why* — never
  restate what the code already says
- **Never** use section-marker comments (`// --- Section ---`, `// ===`, etc.); a file that needs a
  table of contents needs splitting instead
- A comment that could be deleted without losing information should be deleted
</content>
</invoke>
