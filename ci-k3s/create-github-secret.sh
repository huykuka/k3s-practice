#!/bin/bash
# Make sure this script runs with bash

# Define the path to the .env file
ENV_FILE="ci-k3s/.env"

# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

# Source the .env file to read the variables
. "$ENV_FILE"

# Check if GITHUB_PAT or GITHUB_RUNNER_TOKEN exists in the .env file
if [ -z "$GITHUB_PAT" ] && [ -z "$GITHUB_RUNNER_TOKEN" ]; then
    echo "Error: Neither GITHUB_PAT nor GITHUB_RUNNER_TOKEN found in .env file"
    exit 1
fi

# Create a temporary file for the Secret YAML
cat > github-runner-secret.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  namespace: ci-k3s
  name: github-runner-token
type: Opaque
data:
EOF

# Add the appropriate token to the Secret
if [ ! -z "$GITHUB_PAT" ]; then
    # Base64 encode the PAT and add to the Secret
    echo "  GITHUB_PAT: $(echo -n $GITHUB_PAT | base64)" >> github-runner-secret.yaml
elif [ ! -z "$GITHUB_RUNNER_TOKEN" ]; then
    # Base64 encode the Runner token and add to the Secret
    echo "  GITHUB_RUNNER_TOKEN: $(echo -n $GITHUB_RUNNER_TOKEN | base64)" >> github-runner-secret.yaml
fi

# Apply the Secret to the cluster
kubectl apply -f github-runner-secret.yaml

echo "Secret 'github-runner-token' created successfully"

# Optional: Clean up the temporary file
# rm github-runner-secret.yaml
