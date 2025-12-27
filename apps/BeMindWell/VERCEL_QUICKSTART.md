# Vercel Deployment Quick Start

Quick guide to deploy BeMindWell to www.bemindwell.com.au

## Prerequisites

- Vercel account (free at https://vercel.com)
- Access to www.bemindwell.com.au DNS
- GitHub repository access

## 5-Minute Setup

### 1. Create Vercel Project

**Note:** This is a monorepo project using Yarn workspaces.

```bash
# From repository root
yarn install

# Navigate to app directory
cd apps/BeMindWell
vercel login
vercel link
```

Or via Vercel Dashboard:
1. Go to https://vercel.com/new
2. Import `BenjaminMoustakis/expo` repository
3. Set Root Directory: `apps/BeMindWell`
4. Build Command: `cd ../.. && yarn install --frozen-lockfile && cd apps/BeMindWell && yarn export:web`
5. Output Directory: `web-build`
6. Install Command: `yarn install`
7. Deploy

### 2. Get Credentials

```bash
# Get Project ID and Org ID
cat .vercel/project.json
```

Generate token at: https://vercel.com/account/tokens

### 3. Add GitHub Secrets

Go to: Repository → Settings → Secrets → Actions

Add these 3 secrets:
- `VERCEL_TOKEN` - Your token from step 2
- `VERCEL_ORG_ID` - From .vercel/project.json
- `VERCEL_PROJECT_ID` - From .vercel/project.json

### 4. Add Custom Domain

In Vercel Dashboard:
1. Go to project Settings → Domains
2. Add: `www.bemindwell.com.au`
3. Configure DNS with provided records

### 5. Deploy

Push to main branch or run manually:
```bash
# Via GitHub Actions
# Push to main/master branch

# Or manually
vercel --prod
```

## Automated Deployment

✅ Workflow configured at: `.github/workflows/bemindwell-deploy.yml`

- **Push to main/master** → Production deployment
- **Pull requests** → Preview deployments
- **Manual trigger** → Available in Actions tab

## Files Created

- `vercel.json` - Vercel configuration
- `.vercelignore` - Deployment exclusions
- `.github/workflows/bemindwell-deploy.yml` - GitHub Actions workflow
- `DEPLOYMENT.md` - Detailed documentation
- Updated `package.json` with `export:web` script

## Test Locally

**Note:** This is a monorepo - install dependencies from the root first:

```bash
# From repository root
yarn install

# Navigate to app
cd apps/BeMindWell
yarn export:web
npx serve web-build
```

## Need Help?

See `DEPLOYMENT.md` for comprehensive documentation.

---

**Your web app is ready to deploy to www.bemindwell.com.au! 🚀**
