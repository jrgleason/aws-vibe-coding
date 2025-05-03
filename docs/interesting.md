## To check the url of the lambda

```
aws cloudformation describe-stacks --stack-name vite-react-app --query 'Stacks[0].Outputs[?OutputKey==`ApiEndpoint`].OutputValue' --output text
```

