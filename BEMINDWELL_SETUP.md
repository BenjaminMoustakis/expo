# BeMindWell App - Setup Complete! ✅

## What Has Been Created

A complete **BeMindWell** mobile application has been set up in `apps/BeMindWell/` with:

✅ **Full Expo/React Native app structure**
✅ **iOS and Android configuration**
✅ **EAS Build configuration for App Store publishing**
✅ **Web build configuration for Vercel deployment**
✅ **GitHub Actions workflow for automated deployments**
✅ **Comprehensive documentation**
✅ **Credential setup guides**
✅ **Distribution ZIP creation scripts**

---

## 📁 Project Location

```
apps/BeMindWell/
```

All BeMindWell app files are in this directory.

---

## 🚀 Getting Started

### Quick Start (2 steps)

1. **Navigate to the app directory:**
   ```bash
   cd apps/BeMindWell
   ```

2. **Read the Quick Start Guide:**
   ```bash
   cat QUICKSTART.md
   ```

### Essential Documentation

| Document | Purpose |
|----------|---------|
| **[QUICKSTART.md](apps/BeMindWell/QUICKSTART.md)** | Fast setup and publishing guide |
| **[README.md](apps/BeMindWell/README.md)** | Complete documentation |
| **[CREDENTIALS_GUIDE.md](apps/BeMindWell/CREDENTIALS_GUIDE.md)** | Detailed credential setup |
| **[DEPLOYMENT.md](apps/BeMindWell/DEPLOYMENT.md)** | Web deployment to Vercel guide |
| **[VERCEL_QUICKSTART.md](apps/BeMindWell/VERCEL_QUICKSTART.md)** | Quick Vercel deployment setup |
| **[credentials/README.md](apps/BeMindWell/credentials/README.md)** | Quick credential reference |

---

## 📦 Creating Downloadable ZIP Files

### Method 1: Using the Script (Recommended)

```bash
cd apps/BeMindWell
npm run create-zip
```

This interactive script will guide you through creating:
- Source code ZIP
- Web build ZIP
- Instructions for EAS build downloads

### Method 2: Manual Creation

**Source Code:**
```bash
cd apps/BeMindWell
zip -r BeMindWell-Source-v1.0.0.zip . \
  -x "node_modules/*" ".expo/*" "dist/*" "web-build/*" ".git/*"
```

**Web Build:**
```bash
cd apps/BeMindWell
npx expo export:web
zip -r BeMindWell-Web-v1.0.0.zip web-build/
```

**Production Builds (iOS/Android):**
```bash
cd apps/BeMindWell
# Build with EAS
eas build --profile production --platform ios
eas build --profile production --platform android

# Download builds
eas build:download --platform ios
eas build:download --platform android

# Create ZIPs
zip -r BeMindWell-iOS-v1.0.0.zip path/to/app.ipa
zip -r BeMindWell-Android-v1.0.0.zip path/to/app.aab
```

---

## 🌐 Web Deployment to Vercel

### Deploy to www.bemindwell.com.au

The BeMindWell app is ready for web deployment using Vercel:

**Quick Setup (5 minutes):**

1. **Create Vercel account** at https://vercel.com
2. **Import repository** and set Root Directory to `apps/BeMindWell`
3. **Configure build settings:**
   - Build Command: `cd ../.. && yarn install --frozen-lockfile && cd apps/BeMindWell && yarn export:web`
   - Output Directory: `web-build`
4. **Add GitHub secrets** for automated deployment:
   - `VERCEL_TOKEN`
   - `VERCEL_ORG_ID`
   - `VERCEL_PROJECT_ID`
5. **Configure custom domain** www.bemindwell.com.au in Vercel Dashboard

**Detailed Instructions:**
- **[DEPLOYMENT.md](apps/BeMindWell/DEPLOYMENT.md)** - Complete web deployment guide
- **[VERCEL_QUICKSTART.md](apps/BeMindWell/VERCEL_QUICKSTART.md)** - 5-minute setup guide

**What's Included:**
- ✅ Vercel configuration (`vercel.json`)
- ✅ GitHub Actions workflow for automated deployment
- ✅ Web export scripts in `package.json`
- ✅ Security headers and caching configuration
- ✅ SPA routing support

**Deployment Workflow:**
- **Push to main/master** → Automatic production deployment
- **Pull requests** → Preview deployments with URL in comments
- **Manual trigger** → Deploy on-demand via GitHub Actions

---

## 🏪 Publishing to App Stores

### Prerequisites

Before you can publish, you need:

1. **Apple Developer Account** ($99/year) - for iOS
   - Sign up at: https://developer.apple.com/programs/

2. **Google Play Developer Account** ($25 one-time) - for Android
   - Sign up at: https://play.google.com/console/signup

3. **EAS CLI** installed:
   ```bash
   npm install -g eas-cli
   ```

### Credentials to Fill In

Follow the detailed guide: **[CREDENTIALS_GUIDE.md](apps/BeMindWell/CREDENTIALS_GUIDE.md)**

**Summary of what you need to configure:**

#### iOS Credentials:
- [ ] Create app in App Store Connect
- [ ] Get App Store Connect API key (download `.p8` file)
- [ ] Save `.p8` file in `apps/BeMindWell/credentials/`
- [ ] Update `eas.json` with:
  - Apple ID
  - App Store Connect App ID
  - Apple Team ID

#### Android Credentials:
- [ ] Create app in Google Play Console
- [ ] Create service account and download JSON key
- [ ] Save `google-service-account.json` in `apps/BeMindWell/credentials/`
- [ ] Credentials path already configured in `eas.json`

#### Configuration Files:
- [ ] `app.json` - Add your EAS project ID (line 48)
- [ ] `eas.json` - Fill in iOS credentials (lines 34-36)

### Quick Publishing Steps

```bash
cd apps/BeMindWell

# 1. Login to EAS
eas login

# 2. Configure EAS (first time only)
eas build:configure

# 3. Update app.json with your EAS project ID
# (Edit app.json line 48)

# 4. Set up credentials (follow CREDENTIALS_GUIDE.md)

# 5. Build for production
eas build --profile production --platform ios
eas build --profile production --platform android

# 6. Submit to stores
eas submit --platform ios --profile production
eas submit --platform android --profile production
```

---

## 📋 Configuration Files Created

### Main App Configuration

- **`app.json`** - Expo configuration with:
  - App name: "BeMindWell"
  - Bundle ID (iOS): `com.bemindwell.app`
  - Package name (Android): `com.bemindwell.app`
  - Version: `1.0.0`
  - *Needs: EAS project ID*

- **`eas.json`** - Build and submission configuration with:
  - Build profiles (development, preview, production)
  - iOS submission settings
  - Android submission settings
  - *Needs: Your Apple ID, App IDs, Team ID*

- **`package.json`** - Dependencies and scripts
  - Includes `npm run create-zip` helper script

### Documentation

- **`README.md`** - Comprehensive guide covering:
  - Installation and setup
  - Development workflow
  - Building for production
  - Creating ZIP distributions
  - Publishing to app stores
  - Configuration details
  - Troubleshooting

- **`QUICKSTART.md`** - Quick reference guide for:
  - Fast setup
  - Creating ZIP files
  - Publishing checklist
  - Common issues

- **`CREDENTIALS_GUIDE.md`** - Detailed instructions for:
  - Getting iOS credentials
  - Getting Android credentials
  - Filling in configuration files
  - Security best practices
  - Verification checklist

### Credential Templates

- **`credentials/README.md`** - Quick credential reference
- **`credentials/google-service-account.json.template`** - Android template
- **`.gitignore`** - Configured to exclude all credential files

### Scripts

- **`scripts/create-distribution-zips.sh`** - Interactive script for creating:
  - Source code ZIPs
  - Web build ZIPs
  - Shows instructions for EAS build ZIPs

---

## ✅ What's Configured

### iOS Configuration
✅ Bundle identifier: `com.bemindwell.app`
✅ Build number: `1`
✅ Supports iPad
✅ Custom icon configuration
✅ Placeholder for credentials

### Android Configuration
✅ Package name: `com.bemindwell.app`
✅ Version code: `1`
✅ Adaptive icons
✅ Edge-to-edge enabled
✅ Placeholder for credentials

### Build Configuration
✅ Development profile (for testing)
✅ Preview profile (internal distribution)
✅ Production profile (app stores)
✅ Auto-increment build numbers

### Security
✅ `.gitignore` configured to exclude credentials
✅ Template files provided for credentials
✅ Documentation emphasizes security best practices

---

## 🎯 What You Need to Do

To make BeMindWell fully ready for App Store publishing, you need to:

1. **Fill in your EAS project ID** in `apps/BeMindWell/app.json`
   - Run: `cd apps/BeMindWell && eas build:configure`
   - Copy the project ID to `app.json` line 48

2. **Set up iOS credentials** (if publishing to iOS):
   - Follow: `apps/BeMindWell/CREDENTIALS_GUIDE.md` (iOS section)
   - Update: `apps/BeMindWell/eas.json` with your Apple credentials

3. **Set up Android credentials** (if publishing to Android):
   - Follow: `apps/BeMindWell/CREDENTIALS_GUIDE.md` (Android section)
   - Save service account JSON in `apps/BeMindWell/credentials/`

4. **Build and test:**
   ```bash
   cd apps/BeMindWell
   eas build --profile production --platform ios
   eas build --profile production --platform android
   ```

5. **Submit to stores:**
   ```bash
   eas submit --platform ios --profile production
   eas submit --platform android --profile production
   ```

---

## 📚 Additional Resources

- **Expo Documentation:** https://docs.expo.dev
- **EAS Build:** https://docs.expo.dev/build/introduction/
- **EAS Submit:** https://docs.expo.dev/submit/introduction/
- **Vercel Documentation:** https://vercel.com/docs
- **App Store Connect:** https://appstoreconnect.apple.com
- **Google Play Console:** https://play.google.com/console

---

## 🆘 Need Help?

Refer to:
- `apps/BeMindWell/QUICKSTART.md` for quick answers
- `apps/BeMindWell/README.md` for detailed information
- `apps/BeMindWell/CREDENTIALS_GUIDE.md` for credential setup
- `apps/BeMindWell/DEPLOYMENT.md` for web deployment to Vercel
- `apps/BeMindWell/VERCEL_QUICKSTART.md` for quick Vercel setup
- Expo documentation and community forums

---

## Summary

✅ **BeMindWell app created and configured**
✅ **Ready for development**
✅ **Web deployment ready with Vercel**
✅ **GitHub Actions workflow for automated deployments**
✅ **ZIP creation script available** (`npm run create-zip`)
✅ **Comprehensive documentation provided**
✅ **Placeholder credentials set up**
⚠️ **You need to fill in your actual credentials to publish to app stores**
⚠️ **Configure Vercel secrets for automated web deployments**

Navigate to `apps/BeMindWell/` and start with `QUICKSTART.md` to get going! 🚀

For web deployment to www.bemindwell.com.au, see `DEPLOYMENT.md` or `VERCEL_QUICKSTART.md`! 🌐
