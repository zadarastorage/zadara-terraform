#!/bin/bash
# This script will run as root by cloud-init

# 1. Update and Install Base Packages
# Note: apt-get update is crucial before installing any package
apt-get update
apt-get install -y curl wget git ca-certificates gnupg lsb-release nvtop

# 2. Install Docker
# Note: Using 'sudo' is redundant here as cloud-init runs as root, but safe to leave in.
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin
sudo systemctl enable --now docker

# 3. Add ubuntu user to docker group
# NOTE: This change won't take effect until the 'ubuntu' user logs in next time.
usermod -aG docker ubuntu

# 4. Sleep to allow systems to stabilize
echo "Sleeping for 10 seconds to ensure all services are up..."
sleep 10

# 5. Log git configuration for debugging
echo "Git configuration:"
git config --list

# 6. Install the Onyx repository
# Clone the repository and log output
echo "Cloning repository..."
{
    git clone https://github.com/onyx-dot-app/onyx.git /home/ubuntu/onyx
    echo "Clone completed successfully."
} 2>&1 | tee /tmp/git_clone.log

cp /home/ubuntu/docker-compose.zadara.dev.yml /home/ubuntu/onyx/deployment/docker_compose/

# 7. IMPORTANT: Since this script runs as root, the clone will belong to root.
# We must change ownership to 'ubuntu' so the user can access it.
chown -R ubuntu:ubuntu /home/ubuntu/onyx

# 8. Install Enhanced NVIDIA Driver (consolidated)
curl -O https://us.download.nvidia.com/tesla/570.195.03/nvidia-driver-local-repo-ubuntu2404-570.195.03_1.0-1_amd64.deb
dpkg -i nvidia-driver-local-repo-ubuntu2404-570.195.03_1.0-1_amd64.deb
cp /var/nvidia-driver-local-repo-ubuntu2404-570.195.03/nvidia-driver-local-5F37AB4D-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get install -y nvidia-driver-570

# 9. Install NVIDIA Container Toolkit (consolidated)
# Using a combined command block (no backslash line continuation issues)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
sed 's#deb #deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] #g' | \
tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt-get update
apt-get install -y nvidia-container-toolkit
nvidia-ctk runtime configure --runtime=docker
systemctl restart docker

# 10. Start ONLY Ollama and dependencies first
echo "Starting Ollama..."
docker compose -f /home/ubuntu/onyx/deployment/docker_compose/docker-compose.zadara.dev.yml up -d ollama relational_db index cache minio

# 11. Wait for Ollama to be ready
echo "Waiting for Ollama to wake up..."
sleep 10

# 12. Download the Models (Onyx is NOT running yet, so no errors!)
echo "Pulling models (This may take a while)..."
{
    docker exec ollama ollama pull qwen3:1.7b
    docker exec ollama ollama pull qwen3:32b
    docker exec ollama ollama pull gpt-oss:20b
} 2>&1 | tee /tmp/ollama_pull.log

# 13. NOW start the Onyx API Server (Models are ready!)
echo "Models downloaded. Starting Onyx..."
docker compose -f /home/ubuntu/onyx/deployment/docker_compose/docker-compose.zadara.dev.yml up -d
echo "Waiting for the containers to fully start up..."
sleep 10
docker ps

# 14. --- FINAL SUCCESS CHECK ---
touch /tmp/cloud-init-test-success.txt
echo "Script finished successfully on $(date)" >> /var/log/cloud-init-output.log
