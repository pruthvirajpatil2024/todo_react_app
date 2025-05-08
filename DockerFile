# Step 1: Use official Node.js image to build the React app
FROM node:18-alpine AS build

# Set working directory inside the container
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the production-ready React app
RUN npm run build

# Step 2: Use a lightweight web server to serve the app
FROM nginx:alpine

# Copy the React build to Nginx's public directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy a custom Nginx configuration (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]