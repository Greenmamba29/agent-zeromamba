#!/bin/bash
#
# Agent Zero Mamba - Browser Deployment Script
# This script deploys Agent Zero with web UI for browser access
#

set -e

echo "========================================="
echo "Agent Zero Mamba - Browser Deployment"
echo "========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0;m' # No Color

# Check if Docker is available
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✓ Docker detected${NC}"
    echo ""
    echo "Deploying using Docker (recommended)..."
    echo ""

    # Check if image exists locally
    if docker images | grep -q "agent0ai/agent-zero"; then
        echo -e "${GREEN}✓ Agent Zero image found locally${NC}"
    else
        echo "Pulling Agent Zero Docker image..."
        docker pull agent0ai/agent-zero:latest
    fi

    # Stop existing container if running
    if docker ps -a | grep -q "agent-zero-mamba"; then
        echo "Stopping existing Agent Zero container..."
        docker stop agent-zero-mamba 2>/dev/null || true
        docker rm agent-zero-mamba 2>/dev/null || true
    fi

    # Create data directory
    mkdir -p /home/user/agent-zeromamba-data

    # Run the container
    echo ""
    echo "Starting Agent Zero container..."
    docker run -d \
        --name agent-zero-mamba \
        -p 50080:80 \
        -v /home/user/agent-zeromamba-data:/a0 \
        agent0ai/agent-zero:latest

    echo ""
    echo -e "${GREEN}=========================================${NC}"
    echo -e "${GREEN}✓ Agent Zero deployed successfully!${NC}"
    echo -e "${GREEN}=========================================${NC}"
    echo ""
    echo "Access the web UI at:"
    echo -e "${YELLOW}  http://localhost:50080${NC}"
    echo ""
    echo "Data stored in: /home/user/agent-zeromamba-data"
    echo ""
    echo "To stop: docker stop agent-zero-mamba"
    echo "To view logs: docker logs agent-zero-mamba"
    echo ""

else
    echo -e "${YELLOW}⚠ Docker not detected${NC}"
    echo ""
    echo "Deploying using Python (requires dependencies)..."
    echo ""

    # Check Python
    if ! command -v python3 &> /dev/null; then
        echo -e "${RED}✗ Python 3 is required but not installed${NC}"
        exit 1
    fi

    echo -e "${GREEN}✓ Python $(python3 --version | cut -d' ' -f2) detected${NC}"

    # Install system dependencies
    echo ""
    echo "Installing system dependencies..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update -qq
        sudo apt-get install -y -qq gfortran libopenblas-dev liblapack-dev
    fi

    # Install Python dependencies
    echo ""
    echo "Installing Python dependencies (this may take several minutes)..."
    echo "Installing core packages..."
    python3 -m pip install --user --quiet \
        flask python-dotenv a2wsgi nest-asyncio \
        litellm tiktoken openai anthropic || true

    echo "Installing LangChain and AI packages..."
    python3 -m pip install --user --quiet \
        langchain-core langchain-community || true

    echo "Installing additional dependencies..."
    python3 -m pip install --user --quiet \
        GitPython docker paramiko || true

    # Create basic .env if it doesn't exist
    if [ ! -f ".env" ]; then
        echo ""
        echo "Creating basic .env file..."
        cat > .env << 'EOF'
# Agent Zero Configuration
# Add your API keys here

# OpenAI
# OPENAI_API_KEY=your_key_here

# Anthropic
# ANTHROPIC_API_KEY=your_key_here

# Other settings
WEB_UI_HOST=0.0.0.0
WEB_UI_PORT=50080
EOF
        echo -e "${GREEN}✓ Created .env file${NC}"
        echo "  Please edit .env and add your API keys"
    fi

    echo ""
    echo -e "${GREEN}=========================================${NC}"
    echo -e "${GREEN}✓ Setup complete!${NC}"
    echo -e "${GREEN}=========================================${NC}"
    echo ""
    echo "To start Agent Zero:"
    echo -e "${YELLOW}  python3 run_ui.py${NC}"
    echo ""
    echo "Then access the web UI at:"
    echo -e "${YELLOW}  http://localhost:50080${NC}"
    echo ""
    echo -e "${YELLOW}Note:${NC} For full functionality, configure your API keys in .env"
    echo ""
fi
