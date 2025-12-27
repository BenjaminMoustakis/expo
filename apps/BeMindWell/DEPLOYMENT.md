# BeMindWell Web Deployment Guide

This guide covers deploying the BeMindWell web application to **www.bemindwell.com.au** using Vercel.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Initial Vercel Setup](#initial-vercel-setup)
- [GitHub Actions Workflow](#github-actions-workflow)
- [Manual Deployment](#manual-deployment)
- [Custom Domain Configuration](#custom-domain-configuration)
- [Troubleshooting](#troubleshooting)

## Overview

The BeMindWell app is configured for web deployment with:
- **Expo Web Export** - Generates static web build
- **Vercel** - Hosting and deployment platform
- **GitHub Actions** - Automated deployment workflow
- **Custom Domain** - www.bemindwell.com.au

**Important:** This project is part of a **Yarn workspaces monorepo**. Dependencies must be installed at the repository root level (`expo/`) before working with the BeMindWell app.

## Prerequisites

Before deploying, ensure you have:

1. **Vercel Account** (free tier available)
   - Sign up at: https://vercel.com/signup

2. **Domain Access** 
   - Access to www.bemindwell.com.au DNS settings

3. **GitHub Repository Access**
   - Write access to configure secrets

## Initial Vercel Setup

### Step 1: Install Vercel CLI (Optional for local testing)

```bash
npm install -g vercel
```

### Step 2: Create Vercel Project

1. Log in to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **"Add New Project"**
3. Import your GitHub repository (`BenjaminMoustakis/expo`)
4. Configure project settings:
   - **Framework Preset:** Other
   - **Root Directory:** `apps/BeMindWell`
   - **Build Command:** `cd ../.. && yarn install --frozen-lockfile && cd apps/BeMindWell && yarn export:web`
   - **Output Directory:** `web-build`
   - **Install Command:** `yarn install`

5. Click **"Deploy"**

**Note:** This is a monorepo using Yarn workspaces, so the build command installs dependencies at the root level first.

### Step 3: Get Vercel Credentials

After creating the project, you'll need three values for GitHub Actions:

#### Get Organization ID and Project ID:

1. Go to your project settings in Vercel
2. Click on **"General"** tab
3. Scroll down to find:
   - **Project ID** (e.g., `prj_xxxxxxxxxxxxx`)

4. For Organization ID, go to your account settings:
   - Click your profile icon → **"Settings"**
   - Go to **"General"** tab
   - Find **Team ID** (this is your Org ID)

Or use Vercel CLI:
```bash
cd apps/BeMindWell
vercel link
# This creates .vercel/project.json with projectId and orgId
cat .vercel/project.json
```

#### Generate Vercel Token:

1. Go to [Vercel Account Tokens](https://vercel.com/account/tokens)
2. Click **"Create Token"**
3. Give it a name: `GitHub Actions - BeMindWell`
4. Set scope: **Full Account**
5. Click **"Create Token"**
6. **Copy the token immediately** (you won't see it again!)

### Step 4: Configure GitHub Secrets

Add the following secrets to your GitHub repository:

1. Go to your GitHub repository
2. Navigate to: **Settings** → **Secrets and variables** → **Actions**
3. Click **"New repository secret"** for each:

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `VERCEL_TOKEN` | Your Vercel API token | `AbCdEf123...` |
| `VERCEL_ORG_ID` | Your Vercel organization/team ID | `team_xxxxxxxxxxxxx` |
| `VERCEL_PROJECT_ID` | Your BeMindWell project ID | `prj_xxxxxxxxxxxxx` |

**Important:** Keep these values secure and never commit them to your repository!

## GitHub Actions Workflow

The workflow is located at: `.github/workflows/bemindwell-deploy.yml`

### How It Works

The workflow automatically deploys when:
- **Commits are pushed** to `main` or `master` branch
- **Pull requests** are created (creates preview deployments)
- **Manual trigger** via GitHub Actions UI

### Workflow Steps

1. **Checkout code** - Gets latest code from repository
2. **Setup Node.js** - Installs Node.js v18 with Yarn caching
3. **Install workspace dependencies** - Runs `yarn install` at the repository root (monorepo)
4. **Export web build** - Runs `yarn export:web` to generate static files in BeMindWell directory
5. **Pull Vercel config** - Downloads Vercel environment settings
6. **Build artifacts** - Prepares deployment package
7. **Deploy to Vercel** - Uploads and deploys to Vercel
8. **Comment on PR** - (For PRs) Posts preview URL as comment

### Deployment Types

#### Production Deployment
- Triggered on push to `main`/`master` branch
- Deploys to: `bemindwell.vercel.app` and your custom domain
- Environment: Production

#### Preview Deployment
- Triggered on pull requests
- Deploys to: `bemindwell-git-branch-name.vercel.app`
- Environment: Preview
- Automatically comments on PR with preview URL

#### Manual Deployment
1. Go to **Actions** tab in GitHub
2. Select **"Deploy BeMindWell to Vercel"** workflow
3. Click **"Run workflow"**
4. Select branch
5. Click **"Run workflow"** button

## Manual Deployment

### Local Development Testing

**Note:** This project is part of a monorepo. Install dependencies from the repository root first:

```bash
# From repository root
yarn install

# Navigate to app directory
cd apps/BeMindWell

# Start development server
yarn web

# Build for production
yarn export:web
```

### Deploy Manually with Vercel CLI

**Note:** This project is part of a monorepo. Ensure dependencies are installed at the root:

```bash
# From repository root, install dependencies
yarn install

# Navigate to app directory
cd apps/BeMindWell

# Login to Vercel
vercel login

# Deploy to preview
vercel

# Deploy to production
vercel --prod
```

## Custom Domain Configuration

### Step 1: Add Domain to Vercel

1. Go to your project in [Vercel Dashboard](https://vercel.com/dashboard)
2. Go to **"Settings"** → **"Domains"**
3. Click **"Add"**
4. Enter: `www.bemindwell.com.au`
5. Click **"Add"**

### Step 2: Configure DNS

Vercel will provide DNS records to configure. You have two options:

#### Option A: CNAME Record (Recommended)

Add this CNAME record to your DNS provider:

| Type | Name | Value |
|------|------|-------|
| CNAME | www | cname.vercel-dns.com |

#### Option B: A Records

Add these A records to your DNS provider:

| Type | Name | Value |
|------|------|-------|
| A | www | 76.76.21.21 |
| A | www | 76.76.21.142 |

### Step 3: Verify Domain

1. Wait for DNS propagation (can take up to 48 hours, usually 5-10 minutes)
2. Vercel will automatically verify the domain
3. Once verified, your site will be accessible at www.bemindwell.com.au

### SSL Certificate

Vercel automatically provisions and renews SSL certificates for your custom domain. HTTPS will be enabled automatically.

## Environment Variables

If your app needs environment variables:

1. Go to Vercel Dashboard → Your Project → **"Settings"** → **"Environment Variables"**
2. Add variables for each environment:
   - **Production**
   - **Preview**
   - **Development**

Example:
```
API_URL=https://api.bemindwell.com.au
ANALYTICS_ID=UA-XXXXXXXXX-X
```

## Vercel Configuration

The `vercel.json` file in the project root contains:

- **Build settings** - Commands and output directory
- **Rewrites** - SPA routing configuration
- **Headers** - Security and caching headers
- **Framework** - Set to `null` for custom Expo build

### Key Features

- **SPA Routing:** All routes redirect to `index.html` for client-side routing
- **Security Headers:** XSS protection, frame options, content type sniffing prevention
- **Cache Control:** Static assets cached for 1 year

## Troubleshooting

### Build Fails

**Problem:** Build fails with dependency errors

**Solution:**
```bash
# From repository root
rm -rf node_modules yarn.lock
yarn install

# Then try building again
cd apps/BeMindWell
yarn export:web
```

Or if working in the BeMindWell directory:
```bash
cd apps/BeMindWell
rm -rf node_modules
cd ../..
rm -rf node_modules yarn.lock
yarn install
cd apps/BeMindWell
yarn export:web
```

### Workflow Fails - Missing Secrets

**Problem:** GitHub Actions fails with "Error: No token found"

**Solution:**
- Verify all three secrets are set in GitHub repository settings
- Check secret names match exactly: `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`

### Domain Not Resolving

**Problem:** www.bemindwell.com.au doesn't work

**Solution:**
1. Check DNS propagation: https://dnschecker.org
2. Verify DNS records are correct
3. Wait up to 48 hours for full propagation
4. Ensure domain is verified in Vercel dashboard

### 404 Errors on Refresh

**Problem:** Page refreshes result in 404 errors

**Solution:**
- Ensure `vercel.json` has the rewrite rule (already configured)
- The rewrite rule redirects all routes to `index.html` for SPA routing

### Build Works Locally But Fails on Vercel

**Problem:** Web build works locally but fails in CI/CD

**Solution:**
1. Check Node.js version matches (workflow uses v18)
2. Verify all dependencies are in `package.json` (not just dev machine)
3. Check build logs in GitHub Actions or Vercel dashboard

## Testing Deployment

### Before Going Live

1. **Test preview deployment:**
   - Create a pull request
   - Wait for preview deployment
   - Test all functionality on preview URL

2. **Verify web build locally:**
   ```bash
   cd apps/BeMindWell
   npm run export:web
   npx serve web-build
   ```

3. **Check responsive design:**
   - Test on mobile devices
   - Test on different browsers

### After Deployment

1. **Verify production site:**
   - Check www.bemindwell.com.au loads
   - Test all routes and navigation
   - Verify HTTPS works

2. **Monitor Vercel dashboard:**
   - Check deployment logs
   - Monitor analytics
   - Review function metrics

## Additional Resources

- **Vercel Documentation:** https://vercel.com/docs
- **Expo Web Documentation:** https://docs.expo.dev/guides/customizing-webpack/
- **GitHub Actions Documentation:** https://docs.github.com/en/actions
- **Vercel CLI Reference:** https://vercel.com/docs/cli

## Quick Reference

### Common Commands

```bash
# Start development server
npm run web

# Build for production
npm run export:web

# Deploy to Vercel (manual)
vercel --prod

# Check deployment status
vercel ls

# View logs
vercel logs
```

### Important Files

- `vercel.json` - Vercel configuration
- `.github/workflows/bemindwell-deploy.yml` - GitHub Actions workflow
- `app.json` - Expo web configuration
- `package.json` - Scripts and dependencies

### Support

For deployment issues:
1. Check Vercel deployment logs
2. Review GitHub Actions workflow logs
3. Consult Vercel documentation
4. Check Expo web build documentation

---

**Ready to Deploy!** 🚀

Follow the steps above to deploy BeMindWell to www.bemindwell.com.au using Vercel with automated GitHub Actions deployment.
