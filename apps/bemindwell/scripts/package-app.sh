#!/bin/bash

# BeMindWell App Packaging Script
# This script creates a distributable zipfile of the BeMindWell app

set -e

echo "🎯 BeMindWell App Packaging Script"
echo "===================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
APP_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="${APP_DIR}/dist"

# Create timestamp for the zip file
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ZIP_NAME="BeMindWell_v1.0.0_${TIMESTAMP}.zip"

echo "📦 Preparing to package BeMindWell..."
echo "   App directory: ${APP_DIR}"
echo "   Output directory: ${OUTPUT_DIR}"
echo "   Package name: ${ZIP_NAME}"
echo ""

# Create output directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Create a temporary directory for staging
TEMP_DIR=$(mktemp -d)
STAGE_DIR="${TEMP_DIR}/bemindwell"
mkdir -p "${STAGE_DIR}"

echo "📋 Copying application files..."

# Copy essential files
cp -r "${APP_DIR}/app" "${STAGE_DIR}/" 2>/dev/null || true
cp -r "${APP_DIR}/assets" "${STAGE_DIR}/" 2>/dev/null || true
cp -r "${APP_DIR}/components" "${STAGE_DIR}/" 2>/dev/null || true
cp -r "${APP_DIR}/constants" "${STAGE_DIR}/" 2>/dev/null || true
cp -r "${APP_DIR}/credentials" "${STAGE_DIR}/" 2>/dev/null || true
cp -r "${APP_DIR}/hooks" "${STAGE_DIR}/" 2>/dev/null || true
cp -r "${APP_DIR}/scripts" "${STAGE_DIR}/" 2>/dev/null || true
cp -r "${APP_DIR}/.vscode" "${STAGE_DIR}/" 2>/dev/null || true

# Copy configuration files
cp "${APP_DIR}/app.json" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/eas.json" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/package.json" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/tsconfig.json" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/eslint.config.js" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/.gitignore" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/.npmignore" "${STAGE_DIR}/" 2>/dev/null || true

# Copy documentation files
cp "${APP_DIR}/README.md" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/PACKAGE_INFO.md" "${STAGE_DIR}/" 2>/dev/null || true
cp "${APP_DIR}/PUBLISHING_GUIDE.md" "${STAGE_DIR}/" 2>/dev/null || true

echo "✅ Files copied successfully"
echo ""

# Create a SETUP.md file with quick start instructions
cat > "${STAGE_DIR}/SETUP.md" << 'SETUPEOF'
# BeMindWell - Quick Setup Guide

## 📦 What's Included

This package contains everything you need to develop, build, and publish the BeMindWell application to the App Store and Google Play.

## 🚀 Quick Start

1. **Extract the archive**
   ```bash
   unzip BeMindWell_*.zip
   cd bemindwell
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start development**
   ```bash
   npm start
   ```

## 📱 Running the App

- **iOS**: `npm run ios` (requires macOS and Xcode)
- **Android**: `npm run android` (requires Android Studio)
- **Web**: `npm run web`

## 🔑 Setting Up Credentials for Publishing

### Step 1: Configure iOS Credentials
1. Open `credentials/README.md` for detailed instructions
2. Enroll in Apple Developer Program ($99/year)
3. Create bundle identifier: `com.bemindwell.app`
4. Update `eas.json` with your Apple credentials

### Step 2: Configure Android Credentials
1. Create Google Play Developer account ($25 one-time)
2. Generate keystore:
   ```bash
   keytool -genkeypair -v -storetype JKS -keyalg RSA -keysize 2048 \
     -validity 10000 -alias bemindwell-key \
     -keystore credentials/bemindwell-upload-key.jks
   ```
3. Create service account and download JSON key
4. Place JSON key at: `credentials/google-play-service-account.json`

### Step 3: Build for Production
```bash
# Install EAS CLI
npm install -g eas-cli

# Login to Expo
eas login

# Build
eas build --platform all
```

### Step 4: Submit to Stores
```bash
# iOS
eas submit --platform ios

# Android
eas submit --platform android
```

## 📚 Documentation

- Full README: See `README.md`
- Credentials Guide: See `credentials/README.md`
- Expo Docs: https://docs.expo.dev

## 🆘 Need Help?

- Check the README.md for detailed documentation
- Visit https://docs.expo.dev for Expo documentation
- Join Expo Discord: https://chat.expo.dev

## 🔒 Security Reminder

⚠️ **NEVER commit actual credentials to version control!**

The `credentials/` directory contains templates. Replace placeholders with your actual credentials but keep them secure and private.

---

Happy developing! 🎉
SETUPEOF

echo "📝 Created SETUP.md with quick start instructions"
echo ""

# Create the zip file
echo "🗜️  Creating zip archive..."
cd "${TEMP_DIR}"
zip -r "${OUTPUT_DIR}/${ZIP_NAME}" bemindwell/ -q

# Clean up temporary directory
rm -rf "${TEMP_DIR}"

# Get file size
FILE_SIZE=$(du -h "${OUTPUT_DIR}/${ZIP_NAME}" | cut -f1)

echo ""
echo "✅ Package created successfully!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Package Details:"
echo "   Location: ${OUTPUT_DIR}/${ZIP_NAME}"
echo "   Size: ${FILE_SIZE}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 The BeMindWell app is ready for distribution!"
echo ""
echo "Next steps:"
echo "1. Share the zip file with your team"
echo "2. Extract and run 'npm install'"
echo "3. Configure credentials for App Store and Google Play"
echo "4. Build and publish your app!"
echo ""
