#!/usr/bin/env pwsh

# Get ref
$ref=(& git rev-parse HEAD)

# Create some manual deployments
& gh api `
  --method POST `
  -H "Accept: application/vnd.github+json" `
  -H "X-GitHub-Api-Version: 2022-11-28" `
  /repos/yoannchaudet/deployments/deployments `
  -f ref="$ref" `
  -f description='Deploy via REST API' `
  -f environment='qa'