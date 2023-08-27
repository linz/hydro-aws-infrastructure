import { AwsAccounts } from '@linz/accounts';
import { LinzAccountName } from '@linz/accounts/dist/aws.account.name';
import { Duration, RemovalPolicy, Stack, StackProps } from 'aws-cdk-lib';
import { Bucket, CfnBucket, StorageClass } from 'aws-cdk-lib/aws-s3';
import { Construct } from 'constructs';

export class HydroSurveyStack extends Stack {
  public surveyLandingZoneBucketLogicalId: string;
  public surveyProcessingBucketLogicalId: string;
  public surveyPublicationsBucketLogicalId: string;

  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    let bucketNameSuffix = '';
    if (props?.env?.account !== AwsAccounts.byNameProd(LinzAccountName.HydroSurveys).id) {
      bucketNameSuffix = `-${props?.env?.account}`;
    }

    this.surveyLandingZoneBucketLogicalId = setLogicalId(
      new Bucket(this, 'SurveyLandingZone', {
        bucketName: `ttwlinz-hydro-survey-landing-zone${bucketNameSuffix}`,
        removalPolicy: RemovalPolicy.RETAIN,
      }),
    );

    this.surveyProcessingBucketLogicalId = setLogicalId(
      new Bucket(this, 'SurveyProcessing', {
        bucketName: `ttwlinz-hydro-survey-processing${bucketNameSuffix}`,
        removalPolicy: RemovalPolicy.RETAIN,
        versioned: true,
      }),
    );

    this.surveyPublicationsBucketLogicalId = setLogicalId(
      new Bucket(this, 'SurveyPublications', {
        bucketName: `ttwlinz-hydro-survey-publications${bucketNameSuffix}`,
        lifecycleRules: [
          {
            transitions: [
              {
                storageClass: StorageClass.INFREQUENT_ACCESS,
                transitionAfter: Duration.days(365),
              },
              {
                storageClass: StorageClass.GLACIER,
                transitionAfter: Duration.days(8 * 365),
              },
            ],
          },
        ],
        removalPolicy: RemovalPolicy.RETAIN,
        versioned: true,
      }),
    );

    function setLogicalId(bucket: Bucket): string {
      const cfnBucket = bucket.node.defaultChild as CfnBucket;
      const newLogicalId = hyphenatedToCamelCase(cfnBucket.bucketName!);
      cfnBucket.overrideLogicalId(newLogicalId);
      return newLogicalId;
    }

    function hyphenatedToCamelCase(input: string): string {
      return input.replace(/-(.)/g, (_, char) => char.toUpperCase());
    }
  }
}
