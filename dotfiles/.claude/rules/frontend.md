---
paths:
  - "**/*.tsx"
  - "**/*.ts"
  - "**/*.vue"
---

# Frontend Rules

## TypeScript

- Never use `any`; use `unknown` for truly unknown types and narrow with guards
- Define explicit interfaces or type aliases for all props, function parameters, and return values
- Keep shared types in a co-located `types.ts` file; don't scatter inline type declarations across
  components
- Prefer `interface` for object shapes that may be extended; prefer `type` for unions, intersections,
  and aliases

## File size and decomposition

- Hard limit: **250 lines** per component or module file; if you're approaching it, the file needs
  splitting
- A component file should contain one exported component; sub-components used only within it may
  live in the same file if small, but prefer extracting them once they exceed ~50 lines
- Complex render logic (conditionals, derived values, lists) should be extracted to named variables
  or helper components above the return statement — not inlined in JSX/template

## Single Responsibility

- Each component should do one UI thing and have one reason to change
- Separate concerns strictly:
  - **Component** — markup, layout, event wiring; no raw API calls, no business logic
  - **Hook** (`use*.ts`) — stateful logic, data fetching, side effects; no JSX
  - **Util** (`lib/utils/`) — pure functions, transformations; no side effects, no state
  - **API client** (`lib/api/`) — HTTP calls and response mapping only
- If a component both fetches data and renders it, the fetching belongs in a hook

## Components

- Name components with PascalCase; name files to match (e.g. `UserCard.tsx`, `UserCard.vue`)
- Always define props with an explicit TypeScript interface — never rely on implicit types or
  inline object literals as the prop type
- Avoid prop drilling beyond two levels; lift to context or a shared hook instead
- Prefer composition over configuration: build small focused components and compose them rather
  than adding boolean flags that change a component's behaviour significantly

## Hooks (React)

- Name hooks `use<Domain><Action>` (e.g. `useProjects`, `useImageUpload`)
- A hook should own one domain or concern; split if it grows beyond that
- Follow the established hook pattern: query keys → options interface → query/mutations → typed
  return object (see `src/hooks/HOOK_PATTERN.md`)
- Never call hooks conditionally; move conditional logic inside the hook if needed

## Vue Composition API

- Always use `<script setup lang="ts">` — no Options API, no `defineComponent` wrapper
- Define props with `defineProps<{ ... }>()` using an inline TypeScript interface
- Keep `<script setup>` focused on wiring: derive view-state from composables, handle events, emit
  — complex logic lives in a composable (`use*.ts`)
- One component per `.vue` file; do not define multiple components in a single file

## Naming conventions

- Files: `kebab-case` for utilities, hooks, and modules; `PascalCase` for component files
- Variables and functions: `camelCase`
- Constants (module-level, never reassigned): `SCREAMING_SNAKE_CASE`
- Event handler props: prefix with `on` (e.g. `onSubmit`, `onImageSelect`)

## Comments and documentation

- **JSDoc** (`/** */`): use on all exported functions, hooks, and components; describe *purpose*
  and non-obvious parameters — not implementation steps
- **Inline comments** (`//`): only for genuinely non-obvious one-liners; the comment must explain
  *why*, never restate what the code already says
- **Never** use section-marker comments (`// --- Section ---`, `// ===`, `// ####`, etc.); if a
  file needs a table of contents, it needs splitting instead
- A comment that could be deleted without losing any information should be deleted
