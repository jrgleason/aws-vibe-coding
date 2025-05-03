#!/bin/bash

# Build the application
echo "Building the application..."
npm run build

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

# Create CloudFormation stack if it doesn't exist
echo "Creating/updating CloudFormation stack..."
aws cloudformation deploy \
    --stack-name vite-react-app \
    --template-file cloudformation.yml \
    --capabilities CAPABILITY_IAM

# Get the bucket name from CloudFormation
BUCKET_NAME=$(aws cloudformation describe-stacks \
    --stack-name vite-react-app \
    --query 'Stacks[0].Outputs[?OutputKey==`BucketName`].OutputValue' \
    --output text)

# Deploy to S3
echo "Deploying to S3 bucket: $BUCKET_NAME"
aws s3 sync dist/ s3://$BUCKET_NAME --delete

# Get the website URL
WEBSITE_URL=$(aws cloudformation describe-stacks \
    --stack-name vite-react-app \
    --query 'Stacks[0].Outputs[?OutputKey==`WebsiteURL`].OutputValue' \
    --output text)

echo "Deployment complete!"
echo "Your website is available at: $WEBSITE_URL" 