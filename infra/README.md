# Infra Setup for Dynamic DevOps Project

This directory contains all infrastructure configuration for the **Dynamic DevOps Project**, including Docker, Kubernetes, Terraform, and CI/CD setup with Jenkins.

---

## 📂 Directory Structure
infra/
│── docker/ # Dockerfiles for backend and frontend
│── k8s/ # Kubernetes manifests (deployments, services, ingress)
│── terraform/ # Terraform IaC (resource group, AKS cluster, etc.)
│── ci-cd/ # Jenkins pipeline (Jenkinsfile and job setup)

markdown
Copy code

---

## 🚀 Steps Completed

### 1. Dockerization
- Created Dockerfiles for backend and frontend.
- Configured `.dockerignore`.
- Built and pushed images to DockerHub:
  - `vanshp17/devops01-frontend:latest`
  - `vanshp17/devops01-backend:latest`

### 2. Kubernetes Setup
- Created manifests for:
  - `frontend-deployment.yaml`
  - `frontend-service.yaml`
  - `backend-deployment.yaml` *(optional placeholder)*
  - `backend-service.yaml` *(optional placeholder)*
  - `app-ingress.yaml` (Ingress controller for routing).
- Installed **NGINX ingress controller** in AKS.
- Configured domain-like routing via ingress.

### 3. Terraform Infra
- Defined IaC for:
  - Resource group
  - AKS cluster
  - Supporting networking resources

### 4. Jenkins CI/CD
- Set up Jenkins VM on Azure.
- Installed required plugins (Docker, GitHub, Kubernetes).
- Added credentials (DockerHub, GitHub).
- Created `Jenkinsfile` to automate:
  - Build Docker images
  - Push to DockerHub
  - Apply Kubernetes manifests

---

## ✅ Usage

### Build and Push Docker Images
```bash
docker build -t vanshp17/devops01-frontend:latest -f infra/docker/frontend.Dockerfile .
docker push vanshp17/devops01-frontend:latest

docker build -t vanshp17/devops01-backend:latest -f infra/docker/backend.Dockerfile .
docker push vanshp17/devops01-backend:latest
Deploy to Kubernetes
bash
Copy code
kubectl apply -f infra/k8s/
Access Application
If ingress load balancer has public IP → http://<EXTERNAL-IP>

If not → use port-forward:

bash
Copy code
kubectl port-forward svc/frontend-service 8080:80
Visit → http://localhost:8080

🔑 Notes
Backend is optional (only a placeholder).

All sensitive configs (like .env) are excluded via .gitignore.

Project fully automated with Jenkins pipeline.



