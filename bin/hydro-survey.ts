#!/usr/bin/env node
import 'source-map-support/register';

import { AwsAccounts } from '@linz/accounts';
import { LinzAccountName } from '@linz/accounts/dist/aws.account.name';
import { App } from 'aws-cdk-lib';

import { HydroSurveyStack } from '../lib/hydro-survey-stack';

const ciRoleMapping: { [key: string]: string } = {};
const productionAccountId = AwsAccounts.byNameProd(LinzAccountName.HydroSurveys).id;
ciRoleMapping[productionAccountId] =
  'arn:aws:iam::434775598764:role/ContinuousIntegration-GitHubActionsRole4F1BBA26-U1I7SY11QA7D';
const nonProductionAccountId = '623931144233'; // TODO: AwsAccounts.byNameEnv(LinzAccountName.HydroSurveys, AwsEnv.NonProduction).id
ciRoleMapping[nonProductionAccountId] =
  'arn:aws:iam::623931144233:role/ContinuousIntegration-GitHubActionsRole4F1BBA26-WDE0O3ZN93A6';

const accountId = process.env['CDK_DEFAULT_ACCOUNT']!;

const app = new App();
new HydroSurveyStack(app, 'HydroSurveyStack', {
  env: { account: accountId, region: process.env['CDK_DEFAULT_REGION'] },
});
