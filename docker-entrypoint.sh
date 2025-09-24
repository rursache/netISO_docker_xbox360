#!/usr/bin/env sh
set -eu

# Detect if /data is a mounted volume (works in POSIX sh)
is_mounted() {
  # Check Linux mount tables; ignore errors if files don't exist
  { grep -q " /games " /proc/self/mountinfo 2>/dev/null || grep -q " /games " /proc/mounts 2>/dev/null; }
}

if ! is_mounted; then
  echo "WARNING: /games doesn't appear to be a mounted volume. The server expects to run with its working directory at /data." >&2
fi

# Ensure WINEPREFIX exists and is initialized (no GUI)
: "${WINEPREFIX:=/wineprefix}"
if [ ! -d "$WINEPREFIX" ]; then
  mkdir -p "$WINEPREFIX"
fi
if [ ! -d "$WINEPREFIX/drive_c" ]; then
  wineboot --init || true
fi

# Ensure we run from /games (the user-provided working directory)
cd /games

# Exec the command (Wine + your EXE). Signals/logs are forwarded.
exec "$@"
