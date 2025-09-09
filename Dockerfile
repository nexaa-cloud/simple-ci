# Development stage
FROM node:24-alpine AS development

# Set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install all dependencies (including devDependencies)
RUN npm ci

# Copy source code
COPY . .

# Change ownership to node user
RUN chown -R node:node /usr/src/app

# Switch to non-root user
USER node

# Expose port
EXPOSE 3000

# Start development server
CMD ["npm", "run", "dev"]

# Production stage
FROM node:24-alpine AS production

# Set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy source code
COPY . .

# Change ownership to node user
RUN chown -R node:node /usr/src/app

# Switch to non-root user
USER node

# Expose port
EXPOSE 3000

# Start application
CMD ["npm", "start"]
