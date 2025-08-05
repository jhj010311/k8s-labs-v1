#!/bin/bash
# 사용법: ./check-gradlew.sh <pod-name> [container-name]

POD_NAME=$1
CONTAINER_NAME=$2

if [ -z "$POD_NAME" ]; then
  echo "❌ 사용법: $0 <pod-name> [container-name]"
  exit 1
fi

echo "🔍 ${POD_NAME} 컨테이너에서 gradlew 상태 점검 중..."

KUBECTL_CMD="kubectl exec -it $POD_NAME"
if [ -n "$CONTAINER_NAME" ]; then
  KUBECTL_CMD="$KUBECTL_CMD -c $CONTAINER_NAME"
fi

# 1. 파일 존재 여부
$KUBECTL_CMD -- ls -l ./gradlew 2>/dev/null || {
  echo "❌ gradlew 파일이 현재 작업 디렉터리에 없습니다."
  echo "📌 Pod 안에서 'pwd'와 'ls -l'로 위치 확인 필요"
  exit 1
}

# 2. 실행 권한
PERM=$($KUBECTL_CMD -- stat -c "%A" ./gradlew)
if [[ "$PERM" != *x* ]]; then
  echo "⚠️ 실행 권한 없음 → chmod +x gradlew 필요"
else
  echo "✅ 실행 권한 OK ($PERM)"
fi

# 3. BOM(Byte Order Mark) 존재 여부
BOM_CHECK=$($KUBECTL_CMD -- head -c 3 ./gradlew | hexdump -C | head -n 1)
if [[ "$BOM_CHECK" == *"ef bb bf"* ]]; then
  echo "⚠️ BOM 존재 → sed -i '1s/^\xEF\xBB\xBF//' gradlew 필요"
else
  echo "✅ BOM 없음"
fi

# 4. 줄바꿈(CRLF/LF) 확인
LINE_ENDINGS=$($KUBECTL_CMD -- file ./gradlew)
if [[ "$LINE_ENDINGS" == *"CRLF"* ]]; then
  echo "⚠️ CRLF 줄바꿈 감지 → dos2unix gradlew 필요"
else
  echo "✅ LF 줄바꿈"
fi

# 5. 실행 테스트
echo "🚀 gradlew 실행 테스트"
$KUBECTL_CMD -- ./gradlew --version 2>/dev/null || {
  echo "❌ gradlew 실행 실패 → 위 문제 중 하나 수정 필요"
  exit 1
}

echo "✅ 모든 점검 완료"
