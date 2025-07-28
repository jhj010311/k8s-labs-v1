# 1단계: 빌드 스테이지
FROM node:18 AS builder

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 설치를 위한 package.* 복사
COPY package.json package-lock.json* ./

COPY .env.production .env.production

# 의존성 설치
RUN npm install

# 앱 소스 전체 복사
COPY . .

# 앱 빌드
RUN npm run build

# 2단계: 실행 스테이지 (더 작고 경량화된 이미지)
FROM node:18-alpine

WORKDIR /app

# 프로덕션 의존성만 복사
COPY --from=builder /app/package.json .
COPY --from=builder /app/package-lock.json* ./
RUN npm install --omit=dev

# 빌드 결과 및 필요한 파일 복사
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

# 환경변수 포트
ENV PORT 3000
EXPOSE 3000

# 실행 명령
CMD ["npm", "start"]