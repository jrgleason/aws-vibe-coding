# AWS Vibe Coding

A modern React application built with Vite and TypeScript, deployed to AWS S3 with static website hosting. This is the first step in building a complete serverless architecture that will include:
- API Gateway for request forwarding
- Lambda functions for backend services
- CloudFront for CDN and security
- Route 53 for custom domain support

## Architecture Overview

This project is part of a larger serverless architecture:

1. **Frontend (Current Step)**
   - Vite React application
   - Static hosting on S3
   - Basic website configuration

2. **Backend Services (Coming Soon)**
   - API Gateway endpoints
   - Lambda functions
   - Database integration

3. **Infrastructure (Coming Soon)**
   - CloudFront distribution
   - Custom domain setup
   - CI/CD pipeline

## Getting Started

### Prerequisites
- Node.js (v22.14.0 or compatible version)
- npm
- AWS CLI with SSO configured

### Installation
```bash
npm install
```

### Development
```bash
npm run dev
```

### Building for Production
```bash
npm run build
```

## Deployment

For detailed deployment instructions, see the [Deployment Guide](docs/deployment-guide.md).

## Project Structure

- `src/` - Source code
- `public/` - Static assets
- `dist/` - Production build output
- `docs/` - Documentation
- `cloudformation.yml` - AWS CloudFormation template
- `deploy.sh` - Deployment script

# React + TypeScript + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

## Expanding the ESLint configuration

If you are developing a production application, we recommend updating the configuration to enable type-aware lint rules:

```js
export default tseslint.config({
  extends: [
    // Remove ...tseslint.configs.recommended and replace with this
    ...tseslint.configs.recommendedTypeChecked,
    // Alternatively, use this for stricter rules
    ...tseslint.configs.strictTypeChecked,
    // Optionally, add this for stylistic rules
    ...tseslint.configs.stylisticTypeChecked,
  ],
  languageOptions: {
    // other options...
    parserOptions: {
      project: ['./tsconfig.node.json', './tsconfig.app.json'],
      tsconfigRootDir: import.meta.dirname,
    },
  },
})
```

You can also install [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) and [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) for React-specific lint rules:

```js
// eslint.config.js
import reactX from 'eslint-plugin-react-x'
import reactDom from 'eslint-plugin-react-dom'

export default tseslint.config({
  plugins: {
    // Add the react-x and react-dom plugins
    'react-x': reactX,
    'react-dom': reactDom,
  },
  rules: {
    // other rules...
    // Enable its recommended typescript rules
    ...reactX.configs['recommended-typescript'].rules,
    ...reactDom.configs.recommended.rules,
  },
})
```
