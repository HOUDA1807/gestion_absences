# utilise Node pour builder ton app
FROM node:14 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --production
COPY . .
RUN npm run build   # si tu as un build step, sinon retire

# image finale pour le runtime
FROM node:14
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD ["npm", "start"]
