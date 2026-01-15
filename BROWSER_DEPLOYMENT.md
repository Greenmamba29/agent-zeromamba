# Agent Zero Mamba - Browser Deployment Guide

This guide explains how to deploy Agent Zero Mamba and access it through your web browser.

## Quick Start (Recommended)

### Option 1: Using the Deployment Script

The easiest way to deploy:

```bash
./deploy.sh
```

This script will:
- Detect if Docker is available and use it (recommended)
- Fall back to Python deployment if Docker is not available
- Configure everything automatically
- Start the web server

**Access the web UI at:** `http://localhost:50080`

### Option 2: Using Docker Compose

1. Make sure Docker and Docker Compose are installed
2. Run the deployment:

```bash
docker-compose -f docker-compose.browser-deploy.yml up -d
```

3. Access the web UI at: `http://localhost:50080`

4. Configure your API keys in the web UI Settings

### Option 3: Using Docker Desktop (Windows/Mac/Linux)

If you prefer a GUI approach:

1. Open Docker Desktop
2. Pull the image: Search for `agent0ai/agent-zero` and click Pull
3. Run the container:
   - Click the Run button
   - Set port mapping: `50080:80`
   - (Optional) Map volume: `/path/on/your/machine:/a0`
   - Click Run
4. Access at: `http://localhost:50080`

### Option 4: Direct Docker Command

```bash
docker run -d \
  --name agent-zero-mamba \
  -p 50080:80 \
  -v $(pwd)/agent-zero-data:/a0 \
  agent0ai/agent-zero:latest
```

Access at: `http://localhost:50080`

## Initial Configuration

When you first access the web UI:

1. Click the Settings icon (gear) in the sidebar
2. Configure your LLM provider:
   - **For OpenAI**: Enter your OpenAI API key
   - **For Anthropic**: Enter your Anthropic API key
   - **For Ollama** (local): Set API URL to `http://host.docker.internal:11434`
3. Select your models:
   - Chat Model (main agent)
   - Utility Model (background tasks)
   - Embedding Model (memory/search)
4. Click Save

## Accessing from Other Devices

To access from mobile or other devices on your network:

1. Find your computer's IP address:
   - **Linux/Mac**: `ifconfig` or `ip addr`
   - **Windows**: `ipconfig`
2. Access from other device: `http://<YOUR_IP>:50080`
3. **Important**: Set username/password in Settings → Authentication for security

## Remote Access (Internet)

For internet access, enable Cloudflare Tunnel in Settings → External Services

**⚠️ Security Warning**: Always set authentication (username/password) before enabling internet access!

## Data Persistence

Your Agent Zero data is stored in:
- **Docker**: `./agent-zero-data/` directory
- **Python**: Within the project directory

### Backup Your Data

Use the built-in Backup & Restore feature:
1. Go to Settings → Backup and Restore
2. Click Create Backup
3. Download the backup file
4. Keep it safe!

## Troubleshooting

### Port Already in Use

If port 50080 is already in use, change it:

**Docker command:**
```bash
docker run -d --name agent-zero-mamba -p 8080:80 agent0ai/agent-zero:latest
```
Then access at: `http://localhost:8080`

**Docker Compose:**
Edit `docker-compose.browser-deploy.yml` and change `50080:80` to `8080:80`

### Container Won't Start

Check logs:
```bash
docker logs agent-zero-mamba
```

### Can't Access from Browser

1. Check the container is running:
   ```bash
   docker ps
   ```
2. Verify the port mapping is correct
3. Try accessing `http://localhost:50080` or `http://127.0.0.1:50080`
4. Check firewall settings

### Missing API Keys

Agent Zero requires LLM API keys to function. You can:
- Use OpenAI (requires API key)
- Use Anthropic/Claude (requires API key)
- Use Ollama (free, runs locally) - see docs/installation.md

## Management Commands

### View Logs
```bash
# Docker Compose
docker-compose -f docker-compose.browser-deploy.yml logs -f

# Docker
docker logs -f agent-zero-mamba
```

### Stop Agent Zero
```bash
# Docker Compose
docker-compose -f docker-compose.browser-deploy.yml down

# Docker
docker stop agent-zero-mamba
```

### Restart Agent Zero
```bash
# Docker Compose
docker-compose -f docker-compose.browser-deploy.yml restart

# Docker
docker restart agent-zero-mamba
```

### Update to Latest Version
```bash
# Pull latest image
docker pull agent0ai/agent-zero:latest

# Stop and remove old container
docker stop agent-zero-mamba
docker rm agent-zero-mamba

# Run deployment script again
./deploy.sh
```

## Features Available in Browser UI

- **Chat Interface**: Interact with the AI agent
- **File Upload**: Upload documents for analysis
- **Settings**: Configure models, API keys, prompts
- **Memory Management**: View and manage agent memory
- **Knowledge Base**: Upload and manage knowledge files
- **Multi-Session**: Create and switch between chat sessions
- **Voice Input**: Use speech-to-text (if configured)
- **PWA Support**: Install as standalone app from browser

## Next Steps

- Read the full documentation in `/docs`
- Configure custom prompts in `/prompts`
- Add knowledge files in the web UI
- Explore agent tools and capabilities
- Join the community on Discord or Skool

## Support

- Documentation: See `/docs` folder
- Issues: https://github.com/frdel/agent-zero/issues
- Community: Discord and Skool (links in README)

---

**Enjoy using Agent Zero Mamba! 🚀**
