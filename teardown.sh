#!/bin/bash

# Set the stack name
STACK_NAME="vite-react-app"

echo "Starting teardown of stack: $STACK_NAME"

# Delete the CloudFormation stack
echo "Deleting CloudFormation stack..."
aws cloudformation delete-stack --stack-name $STACK_NAME

# Wait for the stack to be deleted
echo "Waiting for stack deletion to complete..."
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

# Check if the stack was successfully deleted
if [ $? -eq 0 ]; then
    echo "Stack $STACK_NAME has been successfully deleted"
else
    echo "Error deleting stack $STACK_NAME"
    exit 1
fi 