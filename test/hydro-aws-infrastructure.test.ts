import { test } from 'node:test';

import { App } from 'aws-cdk-lib';

import { HydroAwsInfrastructureStack } from '../lib/hydro-aws-infrastructure-stack';

test('Should be able to instantiate stack', () => {
  const app = new App();
  new HydroAwsInfrastructureStack(app, anyStackId());
});

function anyStackId(): string {
  // 1 to 64 alphanumeric characters, starting with an alpha character
  const alphas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  const alphaNumerics = alphas + '0123456789';
  const characterCount = anyNonNegativeInteger(63);

  let result = alphas.charAt(anyNonNegativeInteger(alphas.length));
  for (let counter = 0; counter < characterCount; counter++) {
    result += alphaNumerics.charAt(anyNonNegativeInteger(alphaNumerics.length));
  }
  return result;
}

function anyNonNegativeInteger(stop: number): number {
  return Math.floor(Math.random() * stop);
}
