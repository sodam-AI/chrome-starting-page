# Chrome Starting Page Dashboard v1.0.2

[![Version](https://img.shields.io/badge/version-v1.0.2-blue.svg)](CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/Node.js-v18%2B-brightgreen.svg)](https://nodejs.org)
[![Zero Dependencies](https://img.shields.io/badge/dependencies-zero-orange.svg)](#)

> **Your personal Chrome start page — powered by a local Node.js server with zero external dependencies.**

A feature-rich, self-hosted new-tab dashboard that runs entirely on your machine. No cloud, no sign-up, no data leaving your computer.

---

## Table of Contents

1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Set as Chrome Start Page](#set-as-chrome-start-page)
5. [Usage](#usage)
6. [Data Backup & Restore](#data-backup--restore)
7. [Troubleshooting](#troubleshooting)
8. [Uninstall](#uninstall)
9. [Project Structure](#project-structure)
10. [Technical Specs](#technical-specs)
11. [Changelog](#changelog)

---

## Features

### 📌 Bookmark Manager
- **Category card layout** — organize bookmarks into labeled cards
- **Multi-page support** — create multiple pages, switch via emoji-named tabs
- **Drag & drop** — reorder bookmarks and move them between categories
- **URL drag-in** — drag from the browser address bar directly onto a card
- **Smart paste** — paste a URL to trigger an automatic category-picker popup
- **NEW badge** — highlights bookmarks added in the last 7 days
- **Usage statistics** — URL-based click count and hourly usage pattern tracking
- **Recommendation** — frequently used bookmarks bubble to the top
- **Dead link detection** — auto-detects unreachable sites (after 3 consecutive failures)

### 🔍 Search
- **Multi-engine** — Google, Naver, YouTube and more, one-click switch
- **Spotlight search** (`Ctrl+F`) — unified search across bookmarks, todos, notes, and D-Days
- **Korean initial search** — search with Korean consonants only (e.g. `ㅋㄹㄷ` → 클라우드)
- **Fuzzy matching** — tolerates typos

### 📝 Notes
- **Multiple note cards** — create as many note cards as needed
- **Per-card row count** — adjust the height of each note card independently
- **Real-time auto-save** — changes are saved to the server instantly

### ✅ Todo
- **Priority levels** — High / Medium / Low
- **Tag filtering** — tag-based categorization and filter
- **Due dates** — set deadlines with overdue indicators
- **Recurrence** — daily / weekly / monthly auto-regeneration
- **Completion history** — last 90 days of completed items retained

### 📅 Calendar & Events
- **Month / Week view** — view events on a calendar card
- **Event creation** — set date, time, recurrence, and category
- **Notifications** — browser alerts at event start time

### 🎯 Habit Tracker
- **Daily checklist** — register daily habits and check them off
- **Auto-reset** — resets every midnight

### 📊 D-Day
- **Multiple D-Days** — track several important dates at once
- **Widget** — shows days remaining at the top of the dashboard

### 🕐 Clock & Weather
- **Multi-timezone clocks** — display several time zones simultaneously
- **Time overlay** — large current time shown on top of the background
- **Weather widget** — OpenWeather API integration (API key required)

### 🎨 Theme & Design
- **Themes** — Dark / Light / Auto (time-based)
- **Accent colors** — 8 options (blue, purple, green, orange, etc.)
- **Glass presets** — transparent / default / opaque
- **Blur intensity** — adjustable card background blur
- **Background** — solid color, custom image, or slideshow with auto-transition
- **Layout presets** — default / compact / wide
- **Custom CSS** — write your own CSS for further customization

### ⌨️ Shortcuts & Controls
- **Keyboard navigation** — arrow keys to navigate bookmarks
- **Number key shortcuts** — keys `1`–`9` open the n-th bookmark in the first card
- **Right-click context menu** — edit, move, delete bookmarks
- **Multi-select** — Ctrl/Shift+click to select multiple bookmarks
- **Inline edit** — double-click to rename a bookmark in place
- **Focus mode** — show only bookmarks, hide all other widgets

### 💾 Data & Reliability
- **Auto backup** — smart retention (all for 7 d / 1 per day for 8–30 d / deleted after 30 d / 50-entry cap)
- **Profile management** — switch between multiple profiles (e.g. work / personal)
- **JSON export / import** — full data backup and restore
- **Drag import** — drag a JSON file onto the page to restore data
- **Trash** — recover recently deleted items
- **Offline support** — Service Worker caching keeps the page viewable when the server is stopped
- **Data integrity check** — validated automatically on boot
- **Onboarding** — guided setup shown on first launch

### 🔧 Server
- **Gzip compression** — response compression for faster transfer
- **ETag caching** — returns 304 for unchanged files
- **In-memory cache** — static file caching minimizes disk I/O
- **Graceful shutdown** — auto-backup before process exit
- **Error logging** — errors written to `server.error.log` (10 MB auto-rotation)
- **Background execution** — runs in a hidden PowerShell window (no console)
- **MCP-safe restart** — only kills the dashboard port, leaves other Node processes intact

---

## Requirements

- **Node.js v18 or later** — download the LTS version at [https://nodejs.org](https://nodejs.org)
- Verify: open a terminal and run `node -v` — you should see `v18.x.x` or higher

### What this app does

- Runs a local web server on **port 1111**
- Stores all data as JSON files inside the `data/` directory
- Works without an internet connection (weather widget excepted)
- Never transmits data externally

### What this app does NOT do

- Does not modify the system registry
- Does not interfere with other programs
- Does not use any network resource other than port 1111
- Uses negligible CPU/memory at idle (~15 MB)

---

## Installation

### Windows

**Option 1: Auto-install (recommended)**

1. Place the project folder wherever you like (e.g. `C:\Users\YourName\Dashboard`)
2. Double-click `setup_windows.bat`
3. Once the completion message appears, open `http://localhost:1111` in Chrome

The auto-installer:
- Verifies Node.js is installed
- Starts the server in the background (hidden PowerShell window)
- Registers the server with Windows Startup (auto-launch on boot)

**Option 2: Manual**

```batch
cd C:\Users\YourName\Dashboard
node server.js
```

The terminal shows `[Dashboard v1.0.2] http://localhost:1111/` when ready. Closing the terminal stops the server.

**Restart the server**

```batch
restart.bat
```

Kills only the process on port 1111, then relaunches in the background. Other Node.js processes (e.g. MCP servers) are unaffected.

---

### macOS

**Option 1: Auto-install (recommended)**

```bash
cd ~/Dashboard
chmod +x setup_mac.sh
./setup_mac.sh
```

The auto-installer:
- Verifies Node.js is installed
- Registers a macOS LaunchAgent (auto-launch on login)
- Starts the server immediately

**Option 2: Manual**

```bash
cd ~/Dashboard
node server.js
```

---

### Linux

```bash
cd ~/Dashboard
node server.js
```

For auto-start, register a systemd service:

```bash
sudo tee /etc/systemd/system/dashboard.service << EOF
[Unit]
Description=Chrome Starting Page Dashboard
After=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$HOME/Dashboard
ExecStart=$(which node) server.js
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable dashboard
sudo systemctl start dashboard
```

---

## Set as Chrome Start Page

### Basic setup

1. In Chrome, navigate to `chrome://settings/onStartup`
2. Select **"Open a specific page or set of pages"**
3. Click **"Add a new page"**
4. Enter `http://localhost:1111` and confirm

### Use as New Tab page (optional)

Install the [New Tab Redirect](https://chromewebstore.google.com/detail/new-tab-redirect/icpgjfneehieebagbmdbhnlpiopdcmna) Chrome extension and set the redirect URL to `http://localhost:1111`.

---

## Usage

### Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| `/` or `Ctrl+K` | Focus search bar |
| `Ctrl+F` | Spotlight search (unified) |
| `S` | Open settings |
| `E` | Toggle edit mode |
| `T` | Toggle theme (dark / light) |
| `1`–`9` | Open n-th bookmark in the first card |
| `←` `→` `↑` `↓` | Navigate bookmarks |
| `Escape` | Close modal / search |

### Managing Bookmarks

- **Add**: paste a URL into the input at the bottom of a card, or drag from the browser address bar
- **Reorder**: drag to change order or move to another card
- **Edit**: double-click for inline rename, right-click for full edit
- **Delete**: hover → click the × button (moves to trash, supports Undo)
- **Multi-select**: Ctrl+click to select multiple, then bulk move or delete

### Card Types

| Card | Description |
|---|---|
| **Bookmarks** | Categorized link collections |
| **Notes** | Freeform text notes (multiple cards, configurable row count) |
| **Todo** | Tasks with priority, tags, due dates, and recurrence |
| **Calendar** | Month/week view with event creation and notifications |
| **Habits** | Daily habit checklist (auto-resets at midnight) |

Click **+ Add Card** at the bottom of the page to add any card type.

### Settings (`S` key)

- **Theme**: dark / light / auto, 8 accent colors
- **Glass**: transparency, blur intensity, presets
- **Background**: solid color, image upload, slideshow
- **Weather**: OpenWeather API key + city name
- **Search**: default engine, custom keyword shortcuts
- **D-Day**: important date countdowns
- **Data**: export / import, profile management, dead-link reset

---

## Data Backup & Restore

### Auto Backup

The server creates periodic backups automatically (default: every 24 hours).

**Retention policy:**
- Last 7 days: all backups kept
- Days 8–30: one backup per day
- Older than 30 days: auto-deleted
- Hard cap: 50 backups total

### Manual Backup

Settings (`S`) → Data → **Export** → downloads a JSON file.

### Restore

Settings (`S`) → Data → **Import** → select a JSON file. Or drag and drop a JSON file anywhere on the page.

---

## Troubleshooting

### "Port 1111 already in use"

**Windows:**
```batch
netstat -ano | findstr :1111
taskkill /PID <PID> /F
```

**macOS / Linux:**
```bash
lsof -i :1111
kill <PID>
```

Or change `const PORT = 1111;` in `server.js` to another number and update the Chrome startup URL accordingly.

### Server won't start

1. Verify Node.js: `node -v`
2. Run from the project folder: `cd Dashboard && node server.js`
3. Check that the `data/` folder exists (the server creates it automatically if missing)

### Page won't load

1. Confirm the server is running (check for log output in the terminal)
2. Make sure the URL is `http://localhost:1111` (not **https**)
3. Open DevTools (`F12`) → Console tab for errors

### Icons not showing

Icons are loaded through a 4-stage fallback (Google → DuckDuckGo → icon.horse → direct `favicon.ico`). An internet connection is required. If all sources fail, a two-letter colored glass icon is shown instead.

### Data not saving

- A "⚠ Save failed" indicator appears in the bottom-right → server connection issue
- Restart the server: run `restart.bat`
- Check write permissions on the `data/` folder

---

## Uninstall

No registry entries, global settings, or hidden folders are created. Only two steps are needed.

### Windows

```batch
:: 1. Remove auto-start shortcut
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Dashboard_StartPage.lnk"

:: 2. Stop the server
netstat -ano | findstr :1111 | findstr LISTENING
taskkill /PID <PID> /F

:: 3. Delete the project folder
:: 4. Remove localhost:1111 from chrome://settings/onStartup
```

### macOS

```bash
launchctl unload ~/Library/LaunchAgents/com.dashboard.startpage.plist
rm ~/Library/LaunchAgents/com.dashboard.startpage.plist
rm -rf ~/Dashboard
```

### Linux (systemd)

```bash
sudo systemctl stop dashboard
sudo systemctl disable dashboard
sudo rm /etc/systemd/system/dashboard.service
sudo systemctl daemon-reload
rm -rf ~/Dashboard
```

---

## Project Structure

```
Chrome_Starting-Page/
├── server.js              ← Node.js server (API + static files + Gzip + cache)
├── index.html             ← Page structure
├── style.css              ← Styles (themes, glass, animations)
├── script.js              ← Frontend logic (~2,965 lines)
├── sw.js                  ← Service Worker (offline caching)
├── manifest.webmanifest   ← PWA manifest
├── package.json           ← Project metadata
├── setup_windows.bat      ← Windows auto-installer
├── setup_mac.sh           ← macOS auto-installer
├── restart.bat            ← Server restart (port 1111 only)
├── run_server_background.bat ← Background launcher
├── assets/                ← Background images, PWA icons, slideshow images
└── data/                  ← User data (auto-created)
    ├── bookmarks.json
    ├── config.json
    ├── notes.json
    ├── todos.json
    ├── events.json
    ├── ddays.json
    ├── usage.json
    ├── trash.json
    ├── icons/
    ├── profiles/
    └── backups/
```

---

## Technical Specs

| Item | Detail |
|---|---|
| Server | Node.js (built-in modules only — no `npm install` required) |
| Frontend | Vanilla JS + CSS (no frameworks) |
| Port | 1111 (configurable) |
| Binding | 127.0.0.1 (localhost only — no external access) |
| Data storage | Local JSON files |
| Auto backup | Smart retention (7 d / 30 d / 50-entry cap) |
| Compression | Gzip (HTML, CSS, JS, JSON) |
| Caching | ETag + in-memory static file cache |
| Offline | Service Worker caching |
| Idle memory | ~15 MB |
| Icon fallback | 4-stage chain + in-memory cache |
| Boot | 3-phase (instant render → deferred init → background checks) |

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the full version history.
