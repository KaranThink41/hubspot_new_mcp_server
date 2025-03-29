# Use an official Node.js runtime as the base image
FROM node:lts-alpine

# Set the working directory
WORKDIR /app

# Set default environment variables
ENV HUBSPOT_ACCESS_TOKEN=dummy_access_token
ENV SHARED_CONTACT_ID=12345
ENV USE_TCP=true
ENV TCP_PORT=3000

# Copy package files
COPY package.json package-lock.json* ./

# Install production dependencies and ts-node for running TypeScript files directly
RUN npm install --omit=dev --ignore-scripts && npm install ts-node @types/node typescript

# Copy source code
COPY src ./src
COPY tsconfig.json ./

# Expose the TCP port
EXPOSE 3000

# Start the MCP server with TCP transport
CMD ["node", "--experimental-fetch", "--loader", "ts-node/esm", "src/index.ts"]
