# Hydro AWS infrastructure

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

Code to deploy infrastructure on the "AWS LI Hydro Surveys Prod" account (#434775598764).

## Use

* `yarn cdk deploy` deploy this stack to your default AWS account/region
* `yarn cdk diff` compare deployed stack with current state
* `yarn cdk synth` emits the synthesized CloudFormation template

## Development

* `yarn build` compile typescript to js
* `yarn watch` watch for changes and compile
* `yarn lint` check file formatting
* `yarn test` perform the jest unit tests

### Setup

Prerequisites:

- Install and configure [Node Version Manager](https://github.com/nvm-sh/nvm)

1. Run `nvm install && nvm use` within this project root to use the configured Node.js version. Repeat this and following steps when `.nvmrc` changes.
1. Run `npm update --global yarn` to install the latest Yarn version.
1. Run `yarn` to install packages. Repeat when `yarn.lock` changes.
