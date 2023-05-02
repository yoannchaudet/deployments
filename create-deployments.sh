#!/usr/bin/env pwsh

# Get ref
$ref=(& git rev-parse HEAD)

@('error', 'failure', 'in_progress', 'queue', 'pending', 'inactive', 'success') | ForEach-Object {

  # Create some manual deployments
  $deployment = & gh api `
    --method POST `
    -H "Accept: application/vnd.github+json" `
    -H "X-GitHub-Api-Version: 2022-11-28" `
    /repos/yoannchaudet/deployments/deployments `
    -f ref="$ref" `
    -f description='Deploy via REST API' `
    -f environment='qa' `
    -F auto_merge=false | ConvertFrom-Json

# GitHub CLI api
# https://cli.github.com/manual/gh_api

  write-host $deployment.id

  gh api `
    --method POST `
    -H "Accept: application/vnd.github+json" `
    -H "X-GitHub-Api-Version: 2022-11-28" `
    /repos/yoannchaudet/deployments/deployments/$($deployment.id)/statuses `
    -f state=$_ `
    -f description='Deployment finished successfully.'

}