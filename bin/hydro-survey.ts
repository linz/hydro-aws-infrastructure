#!/usr/bin/env node
import 'source-map-support/register';

import { App } from 'aws-cdk-lib';

import { HydroSurveyStack } from '../lib/hydro-survey-stack';

const app = new App();
new HydroSurveyStack(app, 'HydroSurveyStack', {
  env: { account: process.env['CDK_DEFAULT_ACCOUNT'], region: process.env['CDK_DEFAULT_REGION'] },
});
