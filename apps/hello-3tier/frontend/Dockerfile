# 1단계: 빌드용 이미지
FROM node AS builder

WORKDIR /app

# package.json과 lock 파일 복사 후 의존성 설치
COPY package*.json ./
RUN npm install

# 나머지 앱 소스 복사 및 빌드
COPY . .
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL
RUN npm run build

# 2단계: 실행용 이미지
FROM node AS runner

WORKDIR /app

# 실행에 필요한 파일만 복사
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/next.config.ts ./next.config.ts
COPY --from=builder /app/tsconfig.json ./tsconfig.json

# App Router 기반에선 src/도 필요합니다 (동적 라우팅 관련)
COPY --from=builder /app/src ./src

EXPOSE 3000

# Next.js를 직접 실행 (next start)
CMD ["npx", "next", "start"]
