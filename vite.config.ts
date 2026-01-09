import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    // Expose to all network interfaces (required for Docker)
    host: '0.0.0.0',
    port: 5173,
    strictPort: true,
    watch: {
      // Use polling for file changes in Docker
      // Docker volumes don't always trigger native file watchers
      usePolling: true,
    },
    // Hot Module Replacement configuration for Docker
    hmr: {
      // Tell the browser to connect back via this port
      clientPort: 5173,
    },
  },
  preview: {
    // Preview server (used with `bun run preview`)
    host: '0.0.0.0',
    port: 3000,
    strictPort: true,
  },
})
