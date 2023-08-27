# Hydro AWS infrastructure

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

Code to deploy AWS LI Hydro surveys infrastructure.

## Infrastructure

The result of deploying this should be a stack called "HydroSurveyStack" containing the following:

- A landing zone bucket where survey providers can upload their surveys.
- A processing bucket where Hydro employees can work on surveys.
- A consumption bucket where the public can retrieve survey processing outputs.

## Setup

Prerequisites:

- Install and configure [Node Version Manager](https://github.com/nvm-sh/nvm)

1. Run `nvm install && nvm use` within this project root to use the configured Node.js version. Repeat this and following steps when `.nvmrc` changes.
1. Install packages (repeat when `package-lock.json` changes):
   1. Generate a new [GitHub personal access token (PAT)](https://github.com/settings/tokens/new) with the access "read:packages".
   1. Run `export NODE_AUTH_TOKEN=[the PAT value]` to allow access to install private packages from GitHub within the current shell.
   1. If you're just _deploying_ and not doing development, run `npm install --omit=dev` to install only production packages.
   1. If you're doing _development:_
      - Run `npm install` to install all packages.
      - Optionally install `pre-commit`, then run `pre-commit install --hook-type=commit-msg --hook-type=pre-commit --overwrite` to install the hooks which will automatically lint and format files when committing, and verify commit messages.

## Use

Authenticate using `aws-azure-login --no-prompt --profile="$AWS_PROFILE"`, where `$AWS_PROFILE` is the name of one of the profiles in your `~/.aws/config` file.

- `npm run cdk diff -- --fail --strict` compares the deployed stack with the current state.
- `npm run cdk deploy -- --method=direct --strict` deploys this stack.

**Beware: You _must_ run commands like `npm run RUN_OPTIONS COMMAND -- COMMAND_OPTIONS` (note the `--`). `npm run RUN_OPTIONS COMMAND COMMAND_OPTIONS` (without the `--`) will _not_ do what you expect - [all options will be treated like `npm run` options](https://github.com/npm/cli/issues/6638)!**

## Development

- `npm run build` compiles TypeScript to JavaScript.
- `npm run watch` compiles files when files change.
- `npm run lint` checks file formatting.
- `npm run test` runs the tests.
- `npm run cdk synth` emits the synthesized CloudFormation template.
- `pre-commit run --all-files` runs other linters and formatters manually.
