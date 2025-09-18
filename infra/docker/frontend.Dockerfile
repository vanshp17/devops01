# ---- build stage ----
FROM node:18-alpine AS build

WORKDIR /app

# Copy only package.json and package-lock.json first (for caching)
COPY frontend/package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy rest of frontend source
COPY frontend/ .

# Build the React app
RUN npm run build

# ---- production stage ----
FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy build output to nginx html dir
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config
COPY infra/docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
