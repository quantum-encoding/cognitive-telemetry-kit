#!/bin/bash
# Cognitive State Server Installation Script
# Installs the In-Memory Oracle as a systemd user service

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BINARY="$SCRIPT_DIR/zig-out/bin/cognitive-state-server"
SERVICE_FILE="$SCRIPT_DIR/cognitive-state-server.service"

echo "🧠 Installing Cognitive State Server - The In-Memory Oracle"
echo "═══════════════════════════════════════════════════════════"

# Check if binary exists
if [ ! -f "$BINARY" ]; then
    echo "❌ Binary not found at $BINARY"
    echo "Please run 'zig build' first"
    exit 1
fi

# Install binary
echo "[1/4] Installing binary to /usr/local/bin..."
sudo cp "$BINARY" /usr/local/bin/cognitive-state-server
sudo chmod +x /usr/local/bin/cognitive-state-server

# Install systemd user service
echo "[2/4] Installing systemd user service..."
mkdir -p ~/.config/systemd/user
sed "s/%i/$USER/g" "$SERVICE_FILE" > ~/.config/systemd/user/cognitive-state-server.service

# Reload systemd
echo "[3/4] Reloading systemd daemon..."
systemctl --user daemon-reload

# Enable and start service
echo "[4/4] Enabling and starting service..."
systemctl --user enable cognitive-state-server.service
systemctl --user restart cognitive-state-server.service

# Wait a moment for service to start
sleep 2

# Check status
echo ""
echo "✅ Installation complete!"
echo ""
echo "Service status:"
systemctl --user status cognitive-state-server.service --no-pager -l

echo ""
echo "To check logs:"
echo "  journalctl --user -u cognitive-state-server -f"
echo ""
echo "To test the Oracle:"
echo "  gdbus call --session --dest org.jesternet.CognitiveOracle --object-path /org/jesternet/CognitiveOracle --method org.jesternet.CognitiveOracle.GetCurrentState"
