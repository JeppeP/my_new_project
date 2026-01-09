# Multi-stage Dockerfile for React + Vite + Bun
# Stages: dependencies → development/production

# Stage 1: Install dependencies
FROM oven/bun:1.1.38 AS deps
WORKDIR /app

# Copy package files
COPY package.json bun.lockb* ./

# Install dependencies
RUN bun install --frozen-lockfile

# Stage 2: Development
FROM oven/bun:1.1.38 AS development
WORKDIR /app

# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules

# Copy source code (will be overridden by volume mount in docker-compose)
COPY . .

# Expose Vite dev server port
EXPOSE 5173

# Start Vite dev server
CMD ["bun", "run", "dev"]

# Stage 3: Build for production
FROM oven/bun:1.1.38 AS builder
WORKDIR /app

# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules

# Copy source code
COPY . .

# Build application
RUN bun run build

# Stage 4: Production runtime (minimal)
FROM oven/bun:1.1.38-alpine AS production
WORKDIR /app

# Copy built assets from builder
COPY --from=builder /app/dist ./dist

# Expose preview port
EXPOSE 3000

# Start Vite preview server (serves built app)
CMD ["bun", "run", "preview"]
