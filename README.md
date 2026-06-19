Local Cloud DevOps Pipeline: Automated Infrastructure & Application Deployment for python flask web app

A robust, enterprise-grade CI/CD pipeline built with GitLab CI/CD that automates application testing, containerization, infrastructure provisioning via Terraform, and continuous deployment into a localized cloud simulator powered by LocalStack.

This architecture provides an isolated, cost-free environment for validating Infrastructure as Code (IaC) templates and deployment playbooks before executing them in live public cloud environments.

🏗️ Pipeline Architecture Overview
The automation framework is divided into four structural lifecycle steps designed to minimize bugs and enforce stability:

1. Verification Stage (test)
Executes unit tests and automated linting configurations to verify code readability and identify configuration syntax bugs before compilation.

2. Packaging Stage (build)
Compiles your custom application, builds an optimized Docker base image, and tags/pushes the package directly into your centralized container storage archive.

3. Provisioning Stage (infra)
Launches an isolated LocalStack service container to emulate an active cloud environment. Once the environment is ready, Terraform scripts automatically initialize, map local cloud variables, and deploy mock infrastructure targets (VPCs, Subnets, Security Groups, and EC2 nodes). The final infrastructure state configuration (terraform.tfstate) is preserved as a build artifact.

4. Continuous Delivery Stage (deploy)
Pulls the state parameters captured during infrastructure setup, extracts the dynamic target IP address configuration using jq, and runs automated delivery configurations to safely stand up the newest containerized application directly onto the running infrastructure node.

📂 Project Directory Structure
Plaintext
├── .gitlab-ci.yml             # Global pipeline orchestrations, states, and image variables
├── src/                       # Application code, testing modules, and source logic
├── Dockerfile                 # Docker specifications for software layer builds
└── terraform/                 # Infrastructure configuration blueprints
    ├── provider.tf            # Hardened mock endpoints routing API calls to LocalStack
    └── main.tf                # Declarations defining target EC2 network resource properties
    
⚙️ Configuration Blueprints
1. Cloud Infrastructure Simulator (terraform/provider.tf)
This configuration tells Terraform to redirect structural AWS API resource calls down onto local container sockets rather than requesting real public billing networks:
2. Core Automation Pipeline (.gitlab-ci.yml)
The stable lifecycle logic used to securely run the automated testing, environment configuration, and target orchestration steps:

🚀 Key Takeaways & Learned Objectives
Through this project, I gained deep, hands-on troubleshooting experience solving complex, real-world DevOps synchronization engineering hurdles:

Infrastructure Layer Isolation: Mastered decoupling cloud testing components using customized API endpoint rerouting configurations inside HashiCorp Terraform.

Advanced Git Management: Successfully resolved hidden tracking cache indices and index blindness conditions by resetting untracked submodule caching rules directly inside terminal branches.

WSL Network Troubleshooting: Diagnosed and repaired system-level DNS connection breaks inside local Ubuntu run windows (resolv.conf) to recover dropped network links.

State Management Lifecycles: Configured and passed state engine parameters (.tfstate) across separate infrastructure setup steps using native GitLab artifact storage paths.

<img width="1408" height="768" alt="diagram ci cd" src="https://github.com/user-attachments/assets/55672eb2-2927-4193-aa22-5dc6128ec205" />
