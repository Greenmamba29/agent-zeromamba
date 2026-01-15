# 🚀 Quick Start - Deploy Agent Zero in Your Browser

Get Agent Zero Mamba running in your browser in 3 simple steps!

## The Fastest Way

```bash
# Make the script executable (first time only)
chmod +x deploy.sh

# Run the deployment
./deploy.sh
```

**That's it!** Access Agent Zero at: **http://localhost:50080**

---

## What Happens?

The deployment script automatically:

✅ Detects if Docker is available (recommended path)
✅ Downloads the Agent Zero Docker image
✅ Starts the container with web UI
✅ Sets up data persistence
✅ Makes it accessible in your browser

**No complex configuration needed!**

---

## Alternative: Docker Compose

If you prefer Docker Compose:

```bash
docker-compose -f docker-compose.browser-deploy.yml up -d
```

---

## First-Time Setup (Web UI)

1. Open http://localhost:50080 in your browser
2. Click the Settings ⚙️ icon
3. Add your API key:
   - **OpenAI**: Paste your OpenAI API key
   - **Anthropic**: Paste your Anthropic API key
   - **Ollama** (free, local): URL: `http://host.docker.internal:11434`
4. Select your models
5. Click **Save**

**You're ready to go!**

---

## Usage Tips

### Access from Phone/Tablet

1. Find your computer's IP: Run `hostname -I` (Linux) or `ipconfig` (Windows)
2. Open on your device: `http://YOUR_IP:50080`
3. 🔒 **Set password first!** Settings → Authentication

### Common Commands

```bash
# View logs
docker logs agent-zero-mamba -f

# Stop
docker stop agent-zero-mamba

# Restart
docker restart agent-zero-mamba

# Update to latest
docker pull agent0ai/agent-zero:latest && ./deploy.sh
```

### Use a Different Port

Edit the docker-compose file or run:
```bash
docker run -d --name agent-zero-mamba -p 8080:80 agent0ai/agent-zero:latest
```

---

## Need Help?

- **Full deployment guide**: See `BROWSER_DEPLOYMENT.md`
- **Installation docs**: See `docs/installation.md`
- **Troubleshooting**: See `docs/troubleshooting.md`

---

## Features in the Browser UI

🗨️ **Chat with AI** - Natural language interface
📁 **File Upload** - Analyze documents
🎯 **Tools & Actions** - Execute tasks
🧠 **Memory** - Persistent agent memory
📚 **Knowledge Base** - Upload custom knowledge
⚙️ **Settings** - Full configuration control
🎤 **Voice Input** - Speech-to-text support
📱 **PWA** - Install as app

---

## What's Different from Standard Agent Zero?

This is **Agent Zero Mamba** - an enhanced deployment configuration:

- ✅ Optimized for browser access
- ✅ Simple one-command deployment
- ✅ Pre-configured Docker setup
- ✅ Quick start documentation
- ✅ Mobile-friendly access
- ✅ Easy API key configuration

Everything else is 100% compatible with standard Agent Zero!

---

**🎉 Enjoy your AI agent! Start chatting at http://localhost:50080**

*Need advanced features? Check out the full documentation in `/docs`*
