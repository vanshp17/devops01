#!/usr/bin/env bash
set -euo pipefail

# Run as root or with sudo
# Update and install prerequisites
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io

# Install OpenJDK 11 (Jenkins requirement)
apt-get install -y openjdk-11-jdk

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install kubectl
KUBECTL_VER=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VER}/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Add jenkins user to docker group so Jenkins can run docker
usermod -aG docker jenkins

# Restart services
systemctl enable --now docker
systemctl enable --now jenkins
systemctl restart jenkins

# Optional: install some helpful tools
apt-get install -y git gettext

# Setup a .kube dir for Jenkins (empty for now)
mkdir -p /var/lib/jenkins/.kube
chown -R jenkins:jenkins /var/lib/jenkins/.kube
chmod 700 /var/lib/jenkins/.kube

# Open firewall (optional; Azure NSG still controls public access)
apt-get install -y ufw
ufw allow OpenSSH
ufw allow 8080/tcp
ufw allow 50000/tcp
ufw --force enable

echo "Jenkins setup script finished."
