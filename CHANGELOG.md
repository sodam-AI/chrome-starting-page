# Changelog

All notable changes to this project will be documented in this file.

---

## [v1.0.2] - 2025-02-25

### 🔧 Improved — Icon Loading

- Unified icon loading into a single `resolveIcon()` function across all 4 surfaces (bookmarks, preview, spotlight, smart-paste)
- 4-stage fallback chain: Google → DuckDuckGo → icon.horse → direct `favicon.ico` → glass placeholder
- Per-domain in-memory cache eliminates duplicate network requests

### 🔧 Improved — Dead Link Detection

- Failure counters now persist across page reloads (previously reset on refresh)
- Detection threshold raised from 2 → 3 consecutive failures to reduce false positives
- Dead links are prioritized for re-checking (previously 15 random bookmarks)
- Request timeout increased from 8 s → 12 s to allow for slow sites
- Orphan entries for deleted bookmarks are auto-cleaned on startup
- Added "🔗 Reset Dead Links" button in Settings → Data

### 🔧 Improved — Usage Statistics

- Storage key migrated from `"Category::Name"` string to URL-based key
- 4-stage matching (exact / hostname / URL-contains / partial) auto-migrates existing data
- Hourly usage tracking (`hourly`) for time-based sorting
- Click history retained (last 500 entries)
- Local USAGE map updated immediately on click (no wait for server round-trip)

### ⚡ Improved — Boot Performance

- 3-phase boot sequence: Phase 1 (instant render) → Phase 2 (post-first-paint init) → Phase 3 (background checks after 30 s)
- First backup deferred 60 s to reduce API latency on startup

---

## [v1.0.1] - 2025-02-23

### ✨ Added

- Emoji picker for page tab names
- NEW badge for bookmarks added within the last 7 days
- Search engine tooltip on hover
- Bookmark card height equalization
- Multi-note cards (create as many as needed, configurable row count)
- Widget card show/hide toggle
- Calendar card & Habit tracker
- Pomodoro timer
- Profile management
- Drag-URL bookmark creation
- Multi-select (Ctrl/Shift click)
- Inline rename on double-click
- Focus mode (hides non-bookmark widgets)
- Layout presets (default / compact / wide)
- Smart paste (auto-shows category picker on URL paste)
- Event notifications (browser alert at event start)
- Scroll position restore
- Onboarding guide on first launch

### 🔧 Improved — Server

- Gzip compression + ETag caching + in-memory static file cache
- Smart backup retention policy (all for 7 d / 1 per day for 8–30 d / delete after 30 d / 50-entry cap)
- Background execution (PowerShell hidden window — no console)
- MCP-safe restart: kills only port 1111, leaves other Node processes untouched
- 2-stage icon fallback (Google → DuckDuckGo → glass)

### 🐛 Fixed

- Removed VBS popup on startup
- CSS alignment issues
- Recommendation logic corrections

---

## [v1.0.0] - Initial Release

### ✨ Core Features

- Node.js local server (pure built-in modules, no `npm install` required)
- Category-based bookmark cards
- Dark / Light / Auto theme
- Glass-morphism UI
- Multi-search-engine switcher
- D-Day countdown widget
- Todo management (priority, tags, due dates, recurrence)
- Keyboard shortcuts
- Offline support via Service Worker
