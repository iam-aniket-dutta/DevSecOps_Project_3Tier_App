# --- Stage 1: Build ---
FROM node:21-slim AS builder
WORKDIR /app
# Copy dependency files
COPY package*.json ./
# Install ALL dependencies
RUN npm ci
# Copy source code
COPY . .

# Remove development dependencies to save space
# RUN npm prune --production

# --- Stage 2: Production ---
FROM node:21-slim AS runner
# Set to production for optimization by libraries (like Express/React)
ENV NODE_ENV=production
WORKDIR /app
# Copy production node_modules and built files from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
# If you have a build folder, copy it here:
# COPY --from=builder /app/dist ./dist
COPY --from=builder /app .
EXPOSE 3000
# Using the array form of CMD is the "preferred" way for Docker
CMD ["npm", "start"]