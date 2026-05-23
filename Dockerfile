# Stage 1: Build stage
FROM node:22-slim AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package.json ./
RUN npm install

# Copy project files and build static bundle
COPY . .
RUN npm run build

# Stage 2: Serve stage
FROM nginx:alpine

# Copy Astro built static files to Nginx html directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
