프로젝트 주제: 생성형 AI를 이용한 코스 추천 플랫폼 Place Holder

개발 기간: 
2024.05.30 ~ 2024.07.31

개발환경: 
Flutter 3.22.2, SpringBoot 3.3.0, GitLab 17.1.0, Kubernetes 1.30, Istio 1.22.1, Docker 24.0.7

개발 인원: 
5명

맡은 역할: 
AWS EKS 구축, Flutter를 이용하여 프런트 엔드 구축, GitLab을 이용하여 CI/CD 구축, Amazon CloudWatch를 이용하여 모니터링 구축, AWS Backup을 이용하여 백업계획 설계, 보안 설계

내용 요약:
현대 사회에서 여행은 많은 사람들에게 중요한 여가 활동으로 자리 잡고 있으며, 특히 서울과 같은 대도시는 다양한 볼거리로 관광객들에게 인기가 높습니다. 그러나 여행 계획을 세우는 과정에서 혼잡도와 핫플레이스 정보를 일일이 검색하는 것은 번거롭고 시간 소모적인 일이다. 대부분의 여행 서비스가 정적 정보를 제공하는 데 그쳐 실시간 상황에 유연하게 대응하기 어려운 문제가 있으며, 이를 해결하기 위해 실시간 데이터와 개인화된 추천을 결합한 혁신적인 서비스가 필요합니다. 우리의 프로젝트는 오픈 API를 활용해 실시간 혼잡도와 핫플레이스 정보를 제공하고, AI를 통해 최적의 여행 코스를 추천하는 서비스를 개발하는 것을 목표로 하고 있습니다.
   
Landing Page 

![image](https://github.com/user-attachments/assets/8b4675ea-9eda-4ef9-b973-872053420475)

Main Page

![image](https://github.com/user-attachments/assets/305c21de-51f0-4c9e-b02c-176a2e6b74d8)

Create Course Page

![image](https://github.com/user-attachments/assets/bc32b8c7-71f3-4f3a-a307-33db8a89fe4f)

History Page

![image](https://github.com/user-attachments/assets/22a5244b-240b-4e94-9688-ef989159a48d)

---

AWS 구성도

<img width="452" alt="image" src="https://github.com/user-attachments/assets/bc4d5107-1866-40b7-b7be-6ae0c8746897">

-	AWS의 격리된 가상 네트워크 환경인 VPC를 이용해서 서울 리전에 2개의 VPC를 생성해서 개발 VPC와 운영 VPC를 나누어 관리
-	개발 VPC는 1개의 가용 영역을, 운영 VPC는 2개의 가용 영역을 생성
-	개발 VPC는 가용 영역에 퍼블릭 서브넷을, 운영 VPC는 가용 영역에 프라이빗 서브넷과 퍼블릭 서브넷을 생성
-	운영 VPC의 2개의 가용 영역에 있는 프라이빗 서브넷에 AWS EKS가 관리하는 kubernetes 환경 구성	
-	프라이빗 서브넷에 있는 AWS EKS에 접근하기 위한 ALB와 외부와 통신을 위해 NAT Gateway를 구축
-	모니터링을 위해 CloudWatch agent, Fluent bit, AWS X-Ray를 이용해서 metric, log, trace를 수집 후 수집한 데이터를 Amazon CloudWatch에서 관리, Grafana Cloud를 이용해서 시각화
-	개발 VPC의 퍼블릭 서브넷에 EC2를 생성 후 GitLab을 구성하여 CI/CD관리
-	AWS Amplify를 이용해서 AWS Cognito를 구성, AWS Lambda와 함께 인증과 회원 관리
-	오레곤 리전에 있는 AWS Bedrock을 이용해서 작업을 수행 후 나온 결과 데이터를 AWS Lambda와 API Gateway를 통해 배포

---
 
AWS EKS Cluster 구성도

![image](https://github.com/user-attachments/assets/de16ab73-1d15-4e13-aaa9-57cda887d0c1)

-	고가용성을 위해 HPA와 Karpenter 구축
-	MSA환경을 구성하기 위해 AWS EKS에 Istio Service 구축
-	AWS EKS 외부에 있는 ALB의 접근을 위해 AWS EKS 내부에 Ingress ALB 구성
-	Ingress ALB에서 kubernetes 내에 있는 pod에 접근을 위해 Istio Ingress gateway로 이동 후 Virtual Service를통해 목적에 맞는 pod로 이동
-	모든 Pod들은 Istio proxy container를 생성하여 네트워크 트래픽 관리
-	여러 namespace를 생성하여 역할을 구분
-	Frontend는 phr-fro-ns라는 namespace안에 flutter pod를 구성
-	Backend는 namespace를 유저에 대한 정보를 가져오는 phr-hrd-ns, 경로를 생성하는 phr-cwr-ns, 장소에 대한 정보를 가져오는 Phr-crd-ns를 나누고 SpringBoot pod를 구성
-	모니터링을 위한 CloudWatch agent와 fluent bit, X-ray daemon을 daemonset으로 구성
-	GitLab의 CI/CD를 위해 gitlab agent와 gitlab-runner를 생성

---

Serverless 구성도

![image](https://github.com/user-attachments/assets/697e7da1-e331-417a-a1c5-2ba46f7aea5b)

-	서울 리전에 AWS Amplify를 이용해서 프로젝트를 구성
-	AWS Amplify에 Amazon Cognito를 연결하여 회원 관리
-	AWS Amplify에 사용자 지정 도메인을 정의한 후 ACM을 사용하여 TLS 통신 구성
-	AWS SAM을 이용해서 Serverless용 API를 구성
-	GitHub에 있는 Project Repository와 연결하여 Front Page를 구성
-	GitHub와 AWS Amplify를 이용하여 CI/CD를 구성
-	Amazon CloudWatch를 이용하여 모니터링 구성

---

비교 결과

<img width="321" alt="image" src="https://github.com/user-attachments/assets/af9ab2e6-d3ca-487c-a2fa-5d7728412f8d">

