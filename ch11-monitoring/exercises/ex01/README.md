# 실습 1 : 프로메테우스 & 그라파나 설치 및 기본 사용법

####  모니터링을 위한 네임스페이스 생성
kubectl create namespace monitor

####  kube-prometheus-stack Helm 차트 설치
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-prom-stack prometheus-community/kube-prometheus-stack --namespace monitor
```

#### 설치 확인 및 대시보드 접속
```bash
kubectl get all -n monitor
kubectl port-forward service/kube-prom-stack-kube-prome-prometheus 9090:9090 -n monitor
kubectl port-forward svc/kube-prom-stack-grafana 3000:80 -n monitor
# 그라파나 로그인 정보 
 - id : admin
 - password : prom-operator
```

