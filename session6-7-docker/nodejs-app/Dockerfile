FROM node:24-alpine

WORKDIR /app

# Copy manifests first so `npm install` is cached and only re-runs when
# dependencies actually change, not on every source edit.
COPY package*.json ./
RUN npm install --omit=dev

COPY server.js ./

EXPOSE 3000
CMD ["npm", "start"]
