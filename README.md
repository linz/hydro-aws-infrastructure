# Hydro AWS infrastructure

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

Code to deploy AWS LI Hydro surveys infrastructure.

## Use

Authenticate using `aws-azure-login --no-prompt --profile="$AWS_PROFILE"`

- `npm run cdk synth` emits the synthesized CloudFormation template
- `npm run cdk diff` compare deployed stack with current state
- `npm run cdk deploy` deploy this stack to your default AWS account/region

## Development

- `npm run build` compile typescript to js
- `npm run watch` watch for changes and compile
- `npm run lint` check file formatting
- `npm run test` run the unit tests

### Setup

Prerequisites:

- Install and configure [Node Version Manager](https://github.com/nvm-sh/nvm)

1. Run `nvm install && nvm use` within this project root to use the configured Node.js version. Repeat this and following steps when `.nvmrc` changes.
1. Run `npm i` to install packages. Repeat when `package-lock.json` changes.
