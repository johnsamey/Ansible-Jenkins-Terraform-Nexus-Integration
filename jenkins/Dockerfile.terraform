# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to prevent interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm

# Install necessary packages: Git, SSH, curl, unzip, and dependencies for adding repositories
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ssh \
    curl \
    unzip \
    gnupg \
    software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add HashiCorp GPG key and install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && \
    terraform --version || echo "Terraform installation failed"

# Copy SSH and AWS credentials (ensure these directories are mounted during runtime)
COPY agents_data/.ssh /root/.ssh
COPY agents_data/.aws /root/.aws

# Set correct permissions for SSH keys and AWS credentials
RUN chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/* && \
    chmod 600 /root/.aws/*

# Configure Git user credentials for SSH access
RUN git config --global user.name "Ahmed1958" && \
    git config --global user.email "ahmed195069@feng.bu.edu.eg"

# Set the working directory
WORKDIR /workspace

# Expose the default SSH port (22)
EXPOSE 22

# Set the default command (optional)
ENTRYPOINT ["/bin/bash"]
