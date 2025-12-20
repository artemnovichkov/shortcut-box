# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Swift Package Manager project that generates images from IDE keyboard shortcuts. Main use: updating GitHub Gists daily via GitHub Actions with random shortcut images.

## Architecture

- **Shortcut (library)**: Core reusable library
  - `Models/Shortcuts.swift`: JSON parsing (`Shortcuts` container, `Shortcut` model)
  - `ShortcutView.swift`: SwiftUI view for rendering shortcuts (442x100px, retina scale)
  - `View+ImageData.swift`: SwiftUI → JPEG conversion using ImageRenderer

- **ShortcutBox (executable)**: CLI tool using ArgumentParser
  - Reads JSON file with shortcuts
  - Picks random shortcut
  - Renders to 442x100 image
  - Saves as JPEG

## Common Commands

```bash
# Build
swift build

# Run with arguments
swift run ShortcutBox -i xcode.json -o image.jpg

# GitHub Actions runs daily (00:00 UTC) or on master push
```

## JSON Format

Input files must follow structure:
```json
{
  "name": "IDE Name",
  "shortcuts": [
    {"key": "⌃ + ⌘ + E", "command": "Description"}
  ]
}
```

## Environment

- Requires macOS 26+
- Swift 6.2+
- Dependencies: swift-argument-parser 1.7.0+

## Concurrency

Uses `MainActor.assumeIsolated` to wrap SwiftUI rendering code (`ShortcutView` + `makeImageData`) while keeping `run()` nonisolated for ArgumentParser compatibility.

## GitHub Actions Integration

Workflow clones gist using GH_TOKEN and GIST_TOKEN secrets, generates image, commits to gist repo. See `.github/workflows/schedule.yml`.
