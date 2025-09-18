# ---- build stage ----
FROM node:18-alpine AS build

WORKDIR /app

# Copy only package.json + lock file
COPY backend/package*.json ./ 

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy backend source code
COPY backend/ ./ 

# ---- runtime stage ----
FROM node:18-alpine

WORKDIR /app

# Copy node_modules from build stage
COPY --from=build /app/node_modules ./node_modules

# Copy backend source code
COPY backend/ ./ 

EXPOSE 5000

CMD ["npm", "start"]
