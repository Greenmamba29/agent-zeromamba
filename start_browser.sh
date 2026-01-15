#!/bin/bash
#
# Agent Zero Mamba - Browser Startup Script
# Quick start the web UI for browser access
#

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE} Agent Zero Mamba - Browser Deployment${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""

# Check if .env exists
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Creating .env file...${NC}"
    cat > .env << 'EOF'
# Agent Zero Mamba Configuration
# Add your API keys here

# OpenAI (for GPT models)
# OPENAI_API_KEY=your_key_here

# Anthropic (for Claude models)
# ANTHROPIC_API_KEY=your_key_here

# Web UI Configuration
WEB_UI_HOST=0.0.0.0
WEB_UI_PORT=50080
EOF
    echo -e "${GREEN}✓ .env file created${NC}"
    echo ""
fi

# Start the server
echo -e "${GREEN}Starting Agent Zero web UI...${NC}"
echo ""
echo -e "Access the web UI at:"
echo -e "${YELLOW}  http://localhost:50080${NC}"
echo ""
echo -e "To stop the server, press ${YELLOW}Ctrl+C${NC}"
echo ""
echo "----------------------------------------"
echo ""

# Run the server
python3 run_ui.py
