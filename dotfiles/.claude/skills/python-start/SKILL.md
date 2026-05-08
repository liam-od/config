---
name: python-start
description: Scaffold a new uv Python package project with src layout, pyproject.toml, and pyright .venv config — ready for uv sync and uv run
argument-hint: <name> [description] [python_version] [dep1 dep2 ...]
model: sonnet
effort: low
---

## Arguments

Parse `$ARGUMENTS` as follows:
- The first token is the **project name** (required). Derive `<package_name>` as the snake_case version (hyphens → underscores).
- If no arguments at all are given, ask the user for the project name before proceeding.
- Scan remaining tokens in order:
  - If a token starts with `>=`, `==`, `~=`, or is a bare version like `3.12`, treat it as the **python version specifier** (default: `>=3.12`).
  - Everything else is a **dependency** to add to `dependencies = [...]`.
  - A quoted multi-word string after the name (before any version or deps) is the **description** (default: `""`).

## Steps

1. Parse args as above.

2. Create the directory structure inside the current working directory:
   ```
   <name>/
   ├── pyproject.toml
   └── src/
       └── <package_name>/
           └── __init__.py
   ```

3. Write `pyproject.toml`:
   ```toml
   [project]
   name = "<name>"
   version = "0.1.0"
   description = "<description>"
   requires-python = "<python_version>"
   dependencies = [
       "<dep1>",
       "<dep2>",
   ]

   [build-system]
   requires = ["hatchling"]
   build-backend = "hatchling.build"

   [tool.hatch.build.targets.wheel]
   packages = ["src/<package_name>"]

   [tool.pyright]
   venvPath = "."
   venv = ".venv"
   ```
   Omit the `dependencies` array entries if none were provided (leave it as an empty list).

4. Write `src/<package_name>/__init__.py` as an empty file.

5. Run `cd <name> && uv sync` to create `.venv` and install the package in editable mode.

6. Print the created file tree with `ls -R <name>` and confirm the user can now `cd <name>` and run `uv run python` or `uv run <script>`.
