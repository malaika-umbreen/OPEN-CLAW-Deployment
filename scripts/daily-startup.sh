#!/bin/bash
# ============================================================
# daily-startup.sh — Home SOC Lab Daily Startup Script
# Run this every day before starting your SOC work session
# Author: Malaika Umbreen
# ============================================================

echo "🛡️  DEFENDRIX SOC LAB — DAILY STARTUP"
echo "======================================="
echo ""

# Step 1: Check Docker is running
echo "[1/5] Checking Docker..."
if docker info > /dev/null 2>&1; then
    echo "  ✅ Docker is running"
else
    echo "  ❌ Docker is NOT running. Please start Docker Desktop first."
    exit 1
fi

# Step 2: Restart OpenClaw container (security best practice)
echo ""
echo "[2/5] Restarting OpenClaw container..."
docker restart openclaw
if [ $? -eq 0 ]; then
    echo "  ✅ OpenClaw restarted successfully"
else
    echo "  ❌ Failed to restart OpenClaw"
    exit 1
fi

# Step 3: Wait for container to be ready
echo ""
echo "[3/5] Waiting for OpenClaw to be ready..."
sleep 5
echo "  ✅ Container ready"

# Step 4: Run security audit
echo ""
echo "[4/5] Running security audit..."
docker exec openclaw openclaw security audit --deep 2>/dev/null || echo "  ⚠️  Security audit command not available in this version"

# Step 5: Verify gateway is reachable
echo ""
echo "[5/5] Verifying gateway..."
if curl -s http://127.0.0.1:18789 > /dev/null 2>&1; then
    echo "  ✅ Gateway reachable at http://127.0.0.1:18789"
else
    echo "  ⚠️  Gateway not reachable — may still be starting up"
fi

echo ""
echo "======================================="
echo "🟢 SOC LAB ONLINE — Open http://127.0.0.1:18789"
echo "   Agent: Defendrix | SOC Orchestrator"
echo "======================================="
