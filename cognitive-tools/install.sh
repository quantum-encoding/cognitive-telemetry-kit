#!/bin/bash
# Install cognitive tools globally
set -e

echo "🔨 Building cognitive tools..."
zig build

echo "📦 Installing binaries to /usr/local/bin..."
sudo cp zig-out/bin/cognitive-export /usr/local/bin/
sudo cp zig-out/bin/cognitive-stats /usr/local/bin/
sudo cp zig-out/bin/cognitive-query /usr/local/bin/
sudo chmod +x /usr/local/bin/cognitive-export
sudo chmod +x /usr/local/bin/cognitive-stats
sudo chmod +x /usr/local/bin/cognitive-query

echo "✅ Cognitive tools installed successfully!"
echo ""
echo "Available commands:"
echo "  cognitive-export  - Export states to CSV"
echo "  cognitive-stats   - View statistics and analytics"
echo "  cognitive-query   - Advanced search and queries"
echo ""
echo "Try: cognitive-stats"
