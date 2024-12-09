FROM node:22-bookworm-slim AS base
LABEL authors="DueliDev"

#################################################
FROM base AS deps
WORKDIR /app

COPY package*.json ./

RUN apt-get update && apt-get upgrade -y && \
    npm install --omit=dev && npm cache clean --force && \
     apt-get clean && rm -rf /var/lib/apt/lists/*

#################################################
FROM base AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY package*.json ./
COPY ./src src

RUN npm run build && rm -rf ./.next/cache

#################################################
FROM base AS runner
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/.next/ .next

COPY server.js ./

ENV PORT=63150
EXPOSE 63150
ENTRYPOINT ["node", "server.js"]
