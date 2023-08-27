import { test } from 'node:test';

import { App } from 'aws-cdk-lib';
import { Template } from 'aws-cdk-lib/assertions';

import { HydroSurveyStack } from '../lib/hydro-survey-stack';

const app = new App();

const stack = new HydroSurveyStack(app, anyStackId(), {
  env: { account: anyAwsAccountId(), region: anyAwsRegionName() },
});

const template = Template.fromStack(stack);

test('Template configuration', () => {
  template.templateMatches({
    Resources: {
      [stack.surveyLandingZoneBucketLogicalId]: {
        DeletionPolicy: 'Retain',
        UpdateReplacePolicy: 'Retain',
      },
      [stack.surveyProcessingBucketLogicalId]: {
        DeletionPolicy: 'Retain',
        UpdateReplacePolicy: 'Retain',
        Properties: {
          VersioningConfiguration: {
            Status: 'Enabled',
          },
        },
      },
      [stack.surveyPublicationsBucketLogicalId]: {
        DeletionPolicy: 'Retain',
        UpdateReplacePolicy: 'Retain',
        Properties: {
          LifecycleConfiguration: {
            Rules: [
              {
                Status: 'Enabled',
                Transitions: [
                  {
                    StorageClass: 'STANDARD_IA',
                    TransitionInDays: 365,
                  },
                  {
                    StorageClass: 'GLACIER',
                    TransitionInDays: 8 * 365,
                  },
                ],
              },
            ],
          },
          VersioningConfiguration: {
            Status: 'Enabled',
          },
        },
      },
    },
  });
});

function anyAwsAccountId(): string {
  // 12 digits, starting with a non-zero digit
  const digits = [1 + anyNonNegativeInteger(9)];

  for (let counter = 0; counter < 11; counter++) {
    digits.push(anyNonNegativeInteger(10));
  }

  return digits.join('');
}

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

function anyAwsRegionName(): string {
  const allRegions = [
    'af-south-1',
    'ap-east-1',
    'ap-northeast-1',
    'ap-northeast-2',
    'ap-northeast-3',
    'ap-south-1',
    'ap-south-2',
    'ap-southeast-1',
    'ap-southeast-2',
    'ap-southeast-3',
    'ap-southeast-4',
    'ca-central-1',
    'eu-central-1',
    'eu-central-2',
    'eu-north-1',
    'eu-south-1',
    'eu-south-2',
    'eu-west-1',
    'eu-west-2',
    'eu-west-3',
    'il-central-1',
    'me-central-1',
    'me-south-1',
    'sa-east-1',
    'us-east-1',
    'us-east-2',
    'us-west-1',
    'us-west-2',
  ];
  const randomIndex = anyNonNegativeInteger(allRegions.length);
  return allRegions[randomIndex]!;
}

function anyNonNegativeInteger(stop: number): number {
  return Math.floor(Math.random() * stop);
}
