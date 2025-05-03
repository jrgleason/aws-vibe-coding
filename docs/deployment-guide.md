# Vite React Application Deployment Guide

This guide walks through the first step of setting up a Vite React application with AWS infrastructure. This initial setup deploys the frontend to S3 with static website hosting. Future steps will include:
- Setting up API Gateway for request forwarding
- Configuring Lambda functions for backend services
- Implementing CloudFront for CDN and security
- Adding Route 53 for custom domain support

## Table of Contents
- [Prerequisites](#prerequisites)
- [Project Setup](#project-setup)
- [AWS Configuration](#aws-configuration)
- [Deployment](#deployment)
- [Accessing Your Application](#accessing-your-application)
- [Next Steps](#next-steps)

## Prerequisites

Before you begin, ensure you have the following installed:
- Node.js (v22.14.0 or compatible version)
- npm (Node Package Manager)
- AWS CLI
- AWS SSO configured

## AWS CLI Setup

Before deploying, you'll need to set up AWS CLI with SSO access. Follow these steps:

1. **Gather Required Information**
   - Navigate to `IAM Identity Center > Dashboard` and note the AWS access portal URL
   - Go to `IAM Identity Center > AWS Organizations: AWS accounts` and note your account number

2. **Create Access Group**
   - Navigate to `IAM Identity Center > Groups`
   - Create a new group for CLI access
   - Add appropriate team members to the group

3. **Create Permission Set**
   - Go to `IAM Identity Center > Permission sets`
   - Create a new permission set
   - For development purposes, you might use `AdministratorAccess`
   - For production, create a more granular permission set with only the necessary permissions:
     - `s3:PutObject`
     - `s3:GetObject`
     - `s3:ListBucket`
     - `cloudformation:*`
     - `iam:PassRole`

4. **Assign Permissions**
   - Navigate to `IAM Identity Center > AWS accounts`
   - Select your account
   - Choose "Assign users or groups"
   - Select your group and permission set
   - Complete the assignment

5. **Configure AWS CLI**
   Create or update your `~/.aws/config` file with:
   ```ini
   [profile default]
   sso_start_url = https://your-portal.awsapps.com/start
   sso_region = us-east-2
   region = us-east-2
   sso_account_id = 123456789012
   sso_role_name = AdministratorAccess
   ```

6. **Verify Setup**
   ```bash
   # Login to AWS SSO
   aws sso login

   # Verify access
   aws s3 ls
   ```

   If successful, you should see a list of your S3 buckets (if any exist).

## Project Setup

1. **Create a new Vite React project**
   ```bash
   npm create vite@latest . -- --template react-ts
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Test the application locally**
   ```bash
   # Development server
   npm run dev
   
   # Production build
   npm run build
   
   # Preview production build
   npm run preview
   ```

## AWS Configuration

1. **AWS SSO Login**
   ```bash
   aws sso login
   ```

2. **CloudFormation Template**
   We use a CloudFormation template (`cloudformation.yml`) to create:
   - S3 bucket for hosting
   - Bucket policy for public access
   - Website configuration

   The template includes:
   - Static website hosting configuration
   - Public access settings
   - Outputs for bucket name and website URL

## Deployment

1. **Build the application**
   ```bash
   npm run build
   ```

2. **Run the deployment script**
   ```bash
   ./deploy.sh
   ```

   The deployment script (`deploy.sh`) performs the following steps:
   - Creates/updates the CloudFormation stack
   - Gets the S3 bucket name from CloudFormation outputs
   - Syncs the built application to the S3 bucket
   - Displays the website URL

## Accessing Your Application

After successful deployment, your application will be available at:
```
http://<bucket-name>.s3-website-<region>.amazonaws.com
```

The exact URL will be displayed in the terminal after deployment completes.

## Troubleshooting

If you encounter any issues:

1. **AWS CLI not found**
   - Ensure AWS CLI is installed
   - Verify AWS SSO is properly configured

2. **Deployment failures**
   - Check CloudFormation stack status
   - Verify S3 bucket permissions
   - Ensure all required AWS permissions are granted

3. **Website not accessible**
   - Verify bucket policy allows public access
   - Check website configuration in S3 bucket settings
   - Confirm CloudFormation stack completed successfully

## Next Steps

After completing this initial deployment, the following steps will be covered in subsequent guides:

1. **API Gateway Setup**
   - Create API Gateway endpoints
   - Configure request forwarding
   - Set up CORS policies

2. **Lambda Functions**
   - Create serverless functions
   - Configure environment variables
   - Set up IAM roles and permissions

3. **CloudFront Distribution**
   - Create CDN distribution
   - Configure SSL certificates
   - Set up security headers

4. **Custom Domain**
   - Register domain in Route 53
   - Configure DNS records
   - Set up SSL certificates

5. **CI/CD Pipeline**
   - Set up GitHub Actions or AWS CodePipeline
   - Configure automated testing
   - Implement deployment strategies

Stay tuned for these additional guides that will complete the full architecture. 