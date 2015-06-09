echo "Setting credential variables..."
export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=

echo "Pushing deployment build to S3..."
cd deployment
aws deploy push --application-name test-app-spk-1 --s3-location s3://test-dev-spk-1/sampleDeployment.zip --ignore-hidden-files 
echo "Deployment build successfully uploaded!"

#Triggering CodeDeploy for Web
aws deploy create-deployment  --application-name test-app-spk-1  --deployment-config-name CodeDeployDefault.OneAtATime   --deployment-group-name test-grp-spk-1  --s3-location bucket=test-dev-spk-1,bundleType=zip,key=sampleDeployment.zip

echo "CodeDeploy on server : Sample application..."