#!/bin/bash

# uninstall_mac.sh - Clean removal of Dashboard (macOS)

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLIST_NAME="com.dashboard.startpage.plist"
PLIST_DEST="$HOME/Library/LaunchAgents/$PLIST_NAME"

echo "============================================"
echo "  Dashboard Starting Page - Uninstall (Mac)"
echo "============================================"
echo ""
echo "  This will:"
echo "    1. Stop the dashboard server"
echo "    2. Remove auto-start (LaunchAgent)"
echo "    3. Optionally delete your data"
echo ""
echo "  This will NOT affect any other programs."
echo ""

# ==========================================
# Step 1: Stop server
# ==========================================
echo "[STEP 1] Stopping server..."
if [ -f "$PROJECT_DIR/.server.pid" ]; then
    PID=$(python3 -c "import json; print(json.load(open('$PROJECT_DIR/.server.pid'))['pid'])" 2>/dev/null)
    if [ -n "$PID" ]; then
        if ps -p "$PID" > /dev/null 2>&1; then
            kill "$PID" 2>/dev/null
            echo "[OK] Server stopped (PID: $PID)"
        else
            echo "[OK] Server was not running"
        fi
    else
        echo "[OK] Could not read PID"
    fi
    rm -f "$PROJECT_DIR/.server.pid"
else
    echo "[OK] Server was not running"
fi
echo ""

# ==========================================
# Step 2: Remove auto-start
# ==========================================
echo "[STEP 2] Removing auto-start..."
if [ -f "$PLIST_DEST" ]; then
    launchctl unload "$PLIST_DEST" 2>/dev/null
    rm -f "$PLIST_DEST"
    echo "[OK] LaunchAgent removed ($PLIST_NAME)"
else
    echo "[OK] No LaunchAgent found"
fi

# Remove local plist copy if exists
if [ -f "$PROJECT_DIR/$PLIST_NAME" ]; then
    rm -f "$PROJECT_DIR/$PLIST_NAME"
fi
echo ""

# ==========================================
# Step 3: Ask about data
# ==========================================
echo "[STEP 3] Your data (bookmarks, notes, settings, etc.)"
echo ""
if [ -f "$PROJECT_DIR/data/bookmarks.json" ]; then
    echo "  Your data folder contains:"
    echo "    - Bookmarks, Notes, Todos, D-Days"
    echo "    - Settings, Usage history"
    echo "    - Backups, Icons, Profiles"
    echo ""
    read -p "  Keep your data? (y/n, default: y): " KEEP_DATA
    KEEP_DATA=${KEEP_DATA:-y}
    if [ "$KEEP_DATA" = "n" ] || [ "$KEEP_DATA" = "N" ]; then
        read -p "  Are you REALLY sure? This cannot be undone. (y/n): " CONFIRM
        if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
            rm -rf "$PROJECT_DIR/data"
            echo "[OK] Data deleted"
        else
            echo "[OK] Data preserved"
        fi
    else
        echo "[OK] Data preserved in data/ folder"
    fi
else
    echo "[OK] No data found"
fi
echo ""

# ==========================================
# Step 4: Clean up runtime files
# ==========================================
echo "[STEP 4] Cleaning up runtime files..."
rm -f "$PROJECT_DIR/server.log"
rm -f "$PROJECT_DIR/server.error.log"
rm -f "$PROJECT_DIR/server.error.log.old"
rm -f "$PROJECT_DIR/.server.pid"
echo "[OK] Runtime files cleaned"
echo ""

# ==========================================
# Done
# ==========================================
echo "============================================"
echo "  Uninstall Complete!"
echo "============================================"
echo ""
echo "  What was removed:"
echo "    - Server stopped"
echo "    - Auto-start disabled (LaunchAgent)"
echo "    - Runtime files cleaned"
echo ""
if [ -d "$PROJECT_DIR/data" ]; then
    echo "  Your data is still in the data/ folder."
    echo "  You can safely delete the entire folder now,"
    echo "  or keep it for reinstalling later."
else
    echo "  You can safely delete the entire folder now."
fi
echo ""
echo "  No system files were modified."
echo "  No other programs were affected."
echo ""
echo "  Remember to remove http://localhost:1111 from"
echo "  Chrome settings (chrome://settings/onStartup)"
echo ""
