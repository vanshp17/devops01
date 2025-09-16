# Use Node.js LTS
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and lock file
COPY ../../backend/package*.json ./

# Install dependencies
RUN npm install --production

# Copy backend source
COPY ../../backend .

# Expose backend port
EXPOSE 5000

# Start backend
CMD ["node", "server.js"]
