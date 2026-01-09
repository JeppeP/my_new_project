# Docker Setup Guide

This project includes Docker configuration for frontend containerization, enabling consistent development environments across team members and systems.

## Quick Start

### Prerequisites
- Docker installed ([Get Docker](https://www.docker.com/products/docker-desktop))
- Bun installed (for Convex CLI)
- `.env.local` configured with Convex credentials

### First Time Setup

```bash
# 1. Copy environment template
cp .env.example .env.local

# 2. Initialize Convex and get deployment info
bunx convex dev
# Copy the CONVEX_URL and CONVEX_DEPLOYMENT from the output

# 3. Update .env.local with values from step 2
# Edit .env.local and paste the values

# 4. Terminal 1: Start Convex backend (on host machine)
bunx convex dev

# 5. Terminal 2: Start Docker frontend
docker-compose up
```

Open http://localhost:5173 in your browser.

## Architecture

```
┌─────────────────────────────────────────┐
│         Your Development Machine        │
├─────────────────────────────────────────┤
│                                         │
│  ┌───────────────────────────────────┐  │
│  │   Docker Container (Isolated)     │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │  Vite Dev Server (5173)    │  │  │
│  │  │  - React Components        │  │  │
│  │  │  - Hot Module Reload       │  │  │
│  │  │  - TypeScript              │  │  │
│  │  └─────────────────────────────┘  │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │  Node Modules (Isolated)   │  │  │
│  │  │  - No conflicts with host  │  │  │
│  │  └─────────────────────────────┘  │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │   Host Machine (Local)            │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │  Convex CLI (bunx convex)  │  │  │
│  │  │  - Cloud Backend            │  │  │
│  │  │  - Dev Database             │  │  │
│  │  │  - Realtime Sync            │  │  │
│  │  └─────────────────────────────┘  │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │   Convex Cloud                    │  │
│  │  - Database                       │  │
│  │  - Functions                      │  │
│  │  - Realtime Subscriptions         │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

## Configuration Files

### Dockerfile
Multi-stage build for both development and production:

- **Stage 1 (deps):** Install dependencies with Bun
- **Stage 2 (development):** Vite dev server with hot reload
- **Stage 3 (builder):** Build artifacts for production
- **Stage 4 (production):** Minimal Alpine-based runtime

Use this for both development and deployment.

### docker-compose.yml
Development orchestration:
- Mounts source code for live editing
- Named volume for node_modules isolation
- Passes Convex environment variables
- Exposes port 5173 for dev server

### docker-compose.prod.yml
Production preview:
- Uses production Dockerfile stage
- Serves built application on port 3000
- No volume mounts (immutable deployment)

### .dockerignore
Optimizes build context to exclude:
- Git files (`.git`, `.gitignore`)
- Dependencies (rebuilt in container)
- Environment files (secrets)
- IDE files (`.vscode`, `.idea`)
- Build artifacts (`dist`, `coverage`)

## Development Commands

### Start Development (Two Terminals)

**Terminal 1: Convex Backend**
```bash
bunx convex dev
```
Starts the Convex development server and displays:
- `CONVEX_URL` - Cloud backend endpoint
- `CONVEX_DEPLOYMENT` - Development deployment ID

**Terminal 2: Docker Frontend**
```bash
docker-compose up
```
Starts Vite development server inside Docker container at http://localhost:5173

### Useful Docker Commands

```bash
# View logs in real-time
docker-compose logs -f frontend

# Run command in container
docker-compose exec frontend bun run lint

# Rebuild image after dependencies change
docker-compose build --no-cache

# Stop containers
docker-compose down

# Stop and remove volumes (clean slate)
docker-compose down -v

# View running containers
docker ps

# SSH into running container
docker-compose exec frontend /bin/bash
```

## Environment Variables

### Required Variables
These MUST be configured in `.env.local`:

```env
VITE_CONVEX_URL=https://your-project.convex.cloud
VITE_CONVEX_DEPLOYMENT=dev:your-deployment-id
```

### How to Get Values
1. Run `bunx convex dev`
2. Copy the `CONVEX_URL` shown in terminal
3. Use `dev:` prefix + deployment ID for `CONVEX_DEPLOYMENT`
4. Paste both into `.env.local`

### Docker Integration
Docker-compose automatically reads `.env.local` and passes these to the container via `environment` variables. Changes to `.env.local` require container restart:

```bash
docker-compose restart frontend
```

## Hot Module Reload (HMR)

HMR is **fully functional** in Docker with the following setup:

### Why Special Configuration is Needed

Docker introduces network isolation, so Vite's HMR needs explicit configuration:

```typescript
// vite.config.ts
server: {
  host: '0.0.0.0',           // Listen on all interfaces
  watch: {
    usePolling: true,        // Docker volumes need polling
  },
  hmr: {
    clientPort: 5173,        // Browser connects back to this port
  },
}
```

### How It Works

1. Edit a file in `src/`
2. Docker file watcher detects change (via polling)
3. Vite compiles the change
4. Browser WebSocket receives update (HMR message)
5. Component refreshes without page reload
6. Your state may be preserved (if using React Fast Refresh)

### Troubleshooting HMR

**Issue:** Changes don't appear in browser
- **Solution:** Check `usePolling: true` is set
- **Verify:** Run `docker-compose logs -f frontend` and look for rebuild messages

**Issue:** WebSocket connection error
- **Solution:** Ensure `hmr.clientPort: 5173` matches exposed port
- **Verify:** Check browser console (DevTools → Network → WS)

**Issue:** Very slow file detection
- **Solution:** Polling has inherent latency (~1-2s); consider native setup for faster iteration
- **Alternative:** Run `bun run dev` natively without Docker

## Production Deployment

### Build for Production

```bash
# Build Docker image
docker-compose -f docker-compose.prod.yml build

# Run production container
docker-compose -f docker-compose.prod.yml up
```

Accesses application at http://localhost:3000

### Production Image Characteristics

- **Base image:** `oven/bun:1.1.38-alpine` (slim)
- **Size:** ~150MB (vs. ~400MB dev image)
- **Contents:** Only built artifacts, no source code
- **Startup:** `bun run preview` (serves static files)

### Deploy to Cloud

The production image can be deployed to any container registry:

```bash
# Tag image for Docker Hub
docker tag my-project:latest yourusername/my-project:latest

# Push to registry
docker push yourusername/my-project:latest

# Or use cloud provider registries
# AWS ECR, GCP Artifact Registry, Azure Container Registry, etc.
```

## Performance Considerations

### Development Performance

**Docker vs. Native:**
- Docker: ~5-10% slower startup
- Docker: Polling-based file watching adds ~1-2s latency
- Docker: HMR still very responsive (mostly imperceptible)

**When to Use Native:**
- Rapid iteration (many quick saves)
- Deep debugging with breakpoints
- Integration testing requiring native file I/O

**When to Use Docker:**
- Testing multi-machine setups
- Matching production environment
- Team onboarding (consistent setup)
- Working with multiple projects

### Optimization Tips

1. **Use named volumes for node_modules:**
   ```yaml
   volumes:
     - node_modules:/app/node_modules
   ```
   Prevents constant host/container syncing

2. **Use .dockerignore:**
   Reduces build context and build time

3. **Layer caching:**
   Dockerfile stages layer dependencies separately for faster rebuilds

4. **Cold start optimization:**
   ```bash
   # Pre-build image
   docker-compose build
   # Then faster subsequent starts
   docker-compose up
   ```

## Troubleshooting

### "Port 5173 already in use"
```bash
# Find process using port
lsof -i :5173

# Kill process
kill -9 <PID>

# Or use different port
docker-compose run -p 5174:5173 frontend
```

### "Cannot connect to Docker daemon"
```bash
# Make sure Docker Desktop is running
# On macOS: Applications → Docker.app
# On Linux: sudo systemctl start docker
```

### "Convex connection error"
```bash
# Verify .env.local has correct values
cat .env.local

# Restart containers
docker-compose restart frontend

# Check logs for connection issues
docker-compose logs frontend | grep -i "convex"
```

### "node_modules permission denied"
```bash
# Clear volume and rebuild
docker-compose down -v
docker-compose build --no-cache
docker-compose up
```

### "File changes not detected"
```bash
# Polling might be too slow or disabled
# Check vite.config.ts has:
# watch: { usePolling: true }

# Increase polling interval if needed:
watch: {
  usePolling: true,
  interval: 1000,  # ms
}
```

## Comparison: Docker vs. Native

| Aspect | Docker | Native |
|--------|--------|--------|
| **Setup Time** | 5-10 minutes | 2-3 minutes |
| **Dependency Isolation** | ✅ Excellent | ❌ Global install |
| **Performance** | ~5-10% slower | Baseline |
| **Multi-project Switch** | ✅ Instant | ❌ Reinstall needed |
| **Deployment Match** | ✅ Identical | ❌ May differ |
| **Team Consistency** | ✅ Guaranteed | ❌ Varies |
| **Debugging** | ⚠️ Terminal access | ✅ Direct |
| **Learning Curve** | ⚠️ Docker knowledge | ✅ None |

## Best Practices

1. **Always use `.env.local` (never `.env`)**
   - `.env.local` is in `.gitignore`
   - Prevents credentials in version control

2. **Commit Dockerfile, not images**
   - Dockerfile describes how to build
   - Images change with code
   - Docker will rebuild as needed

3. **Use named volumes for data**
   - Prevents host/container conflicts
   - Survives container restarts

4. **Separate Convex (host) from Frontend (Docker)**
   - Convex needs local authentication
   - Avoids complex networking
   - Matches development workflow

5. **Keep .dockerignore updated**
   - Exclude secrets and artifacts
   - Reduces build context
   - Speeds up builds

## When NOT to Use Docker

- **Solo project, never deployed** - Docker adds complexity
- **Requires native system access** - Hardware, USB, etc.
- **Very simple setup** - Plain HTML/CSS might not need it
- **Team prefers native** - Honor team preference

## Additional Resources

- [Bun Docker Guide](https://bun.sh/guides/ecosystem/docker)
- [Vite Server Options](https://vitejs.dev/config/server-options.html)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Convex Documentation](https://docs.convex.dev)

## Questions?

Refer to the main README.md or CLAUDE.md for quick commands, or check docs/DECISIONS.md for architecture decisions.
