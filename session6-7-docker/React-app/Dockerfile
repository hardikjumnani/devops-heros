# ---- Stage 1: build the static bundle ----
FROM node:24-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# ---- Stage 2: serve the built assets ----
# Node and the whole node_modules tree are build-time only. The runtime image is
# just nginx plus the compiled bundle, which is a fraction of the size.
FROM nginx:1.27-alpine
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
