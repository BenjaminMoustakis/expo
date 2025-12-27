# Web Deployment Setup - Complete! ✅

## What's Been Configured

Your BeMindWell app is now **ready for web deployment** to **www.bemindwell.com.au** using Vercel! 🚀

### Files Created

1. **`vercel.json`** - Vercel deployment configuration
   - Build commands for monorepo structure
   - Security headers (XSS protection, frame options)
   - Caching configuration for static assets
   - SPA routing support

2. **`.vercelignore`** - Excludes unnecessary files from deployment
   - Node modules, credentials, development files
   - iOS/Android build artifacts

3. **`.github/workflows/bemindwell-deploy.yml`** - Automated deployment workflow
   - Triggers on push to main/master branches
   - Creates preview deployments for pull requests
   - Comments PR with preview URL
   - Manual deployment option via Actions tab

4. **`DEPLOYMENT.md`** - Comprehensive deployment guide
   - Complete Vercel setup instructions
   - GitHub Actions configuration
   - Custom domain setup (www.bemindwell.com.au)
   - Troubleshooting guide

5. **`VERCEL_QUICKSTART.md`** - 5-minute quick start guide
   - Fast setup steps
   - Essential configuration
   - Quick reference

6. **`package.json`** - Updated with web export scripts
   - `yarn export:web` - Build static web files
   - `yarn build:web` - Alternative build command
   - `yarn web` - Start development server

## Quick Start

### Option 1: Use GitHub Actions (Recommended)

1. **Create Vercel Project:**
   - Go to https://vercel.com/new
   - Import this repository
   - Set Root Directory: `apps/BeMindWell`
   - Configure build settings (see DEPLOYMENT.md)

2. **Get Vercel Credentials:**
   - Project ID and Org ID from Vercel project settings
   - Create API token at https://vercel.com/account/tokens

3. **Add GitHub Secrets:**
   - Go to Repository Settings → Secrets → Actions
   - Add: `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`

4. **Deploy:**
   - Push to main/master branch
   - Or use Actions tab to trigger manually

### Option 2: Deploy Manually

```bash
# From repository root
yarn install

# Navigate to app
cd apps/BeMindWell

# Login to Vercel
vercel login

# Deploy
vercel --prod
```

## Custom Domain Setup

To use www.bemindwell.com.au:

1. In Vercel Dashboard, go to your project
2. Settings → Domains → Add Domain
3. Enter: `www.bemindwell.com.au`
4. Configure DNS with provided records:
   - **CNAME:** www → cname.vercel-dns.com

See `DEPLOYMENT.md` for detailed domain configuration.

## Automated Deployment Workflow

✅ **Production Deployment**
- Push to `main` or `master` branch
- Automatically builds and deploys to production
- Updates www.bemindwell.com.au (once domain is configured)

✅ **Preview Deployment**
- Open a pull request
- Automatically creates preview deployment
- Posts preview URL as PR comment
- Perfect for testing before merging

✅ **Manual Deployment**
- Go to Actions tab
- Select "Deploy BeMindWell to Vercel"
- Click "Run workflow"

## What Happens During Deployment

1. **Checkout code** from repository
2. **Install dependencies** at monorepo root (Yarn workspaces)
3. **Export web build** - Creates static files in `web-build/`
4. **Deploy to Vercel** - Uploads files and makes live
5. **Comment on PR** (if applicable) with preview URL

## Testing Locally

Before deploying, test the web build locally:

```bash
# From repository root
yarn install

# Build web version
cd apps/BeMindWell
yarn export:web

# Serve locally
npx serve web-build

# Open browser to http://localhost:3000
```

## Monorepo Notes

**Important:** This project uses Yarn workspaces. Always:
- Install dependencies from repository root: `yarn install`
- Build commands account for monorepo structure
- Vercel configuration includes proper build paths

## Project Structure

```
expo/                           # Repository root
├── .github/
│   └── workflows/
│       └── bemindwell-deploy.yml   # Deployment workflow
├── apps/
│   └── BeMindWell/
│       ├── vercel.json             # Vercel config
│       ├── .vercelignore           # Deployment exclusions
│       ├── DEPLOYMENT.md           # Full deployment guide
│       ├── VERCEL_QUICKSTART.md    # Quick setup guide
│       ├── WEB_DEPLOYMENT_SETUP.md # This file
│       ├── package.json            # Web scripts added
│       ├── app.json                # Web config already set
│       └── web-build/              # Generated after export
└── package.json                    # Workspace root
```

## Security Features

✅ **HTTPS by default** - Automatic SSL certificates
✅ **Security headers** - XSS protection, frame options, content type
✅ **Long-term caching** - Static assets cached for 1 year
✅ **SPA routing** - All routes redirect to index.html

## Environment Variables

If your app needs environment variables:

1. Go to Vercel Dashboard → Project → Settings → Environment Variables
2. Add variables for Production, Preview, Development
3. Examples: `API_URL`, `ANALYTICS_ID`, etc.

## Monitoring

After deployment, monitor via:
- **Vercel Dashboard** - Deployment status, logs, analytics
- **GitHub Actions** - Workflow runs, build logs
- **Domain** - www.bemindwell.com.au (once configured)

## Documentation

For more details, see:

| Document | Purpose |
|----------|---------|
| **DEPLOYMENT.md** | Complete deployment guide with all details |
| **VERCEL_QUICKSTART.md** | Fast 5-minute setup guide |
| **README.md** | Full app documentation |
| **QUICKSTART.md** | App setup and publishing guide |

## Troubleshooting

### Build Fails
- Ensure dependencies installed at root: `yarn install`
- Check workflow logs in Actions tab
- Verify Vercel build command is correct

### Deployment Fails
- Verify all GitHub secrets are set correctly
- Check Vercel token has correct permissions
- Ensure project ID and org ID match

### Domain Not Working
- Verify DNS records in your domain provider
- Wait up to 48 hours for DNS propagation
- Check domain status in Vercel dashboard

For detailed troubleshooting, see `DEPLOYMENT.md`.

## Next Steps

1. ✅ Files created and configured
2. ⏳ Create Vercel project
3. ⏳ Add GitHub secrets
4. ⏳ Configure custom domain
5. ⏳ Deploy!

## Support Resources

- **Vercel Docs:** https://vercel.com/docs
- **Expo Web:** https://docs.expo.dev/workflow/web/
- **GitHub Actions:** https://docs.github.com/en/actions

---

**Your BeMindWell web app is ready to deploy to www.bemindwell.com.au! 🌐**

Follow the quick start above or see `DEPLOYMENT.md` for comprehensive instructions.
