# BeMindWell - Quick Start Guide

This guide will help you quickly get started with building and publishing the BeMindWell app.

## 🚀 Quick Setup (5 minutes)

### Step 1: Install Dependencies

```bash
cd apps/BeMindWell
npm install
```

### Step 2: Start Development

```bash
npm start
```

Then press:
- `i` for iOS simulator
- `a` for Android emulator
- Scan QR code with Expo Go app

---

## 📦 Creating Downloadable ZIP Files

### Quick Method

Run the helper script:

```bash
npm run create-zip
```

This interactive script will help you create:
- Source code ZIP (for developers)
- Web build ZIP (for web deployment)
- Instructions for EAS build ZIPs

### Manual Methods

**Source Code ZIP:**
```bash
zip -r BeMindWell-Source-v1.0.0.zip . \
  -x "node_modules/*" ".expo/*" "dist/*" "web-build/*" ".git/*" "ios/*" "android/*"
```

**Web Build ZIP:**
```bash
npx expo export:web
zip -r BeMindWell-Web-v1.0.0.zip web-build/
```

**EAS Builds:**
```bash
# Build
eas build --profile production --platform ios
eas build --profile production --platform android

# Download and create ZIP
eas build:download --platform ios
zip -r BeMindWell-iOS-v1.0.0.zip path/to/app.ipa
```

---

## 🏪 Publishing to App Stores - Checklist

### Before You Start

- [ ] Apple Developer Account ($99/year) - for iOS
- [ ] Google Play Developer Account ($25 one-time) - for Android
- [ ] EAS CLI installed: `npm install -g eas-cli`
- [ ] Logged into EAS: `eas login`

### Configure Credentials (Required!)

Follow the detailed guide: [CREDENTIALS_GUIDE.md](./CREDENTIALS_GUIDE.md)

**Quick checklist:**

#### iOS:
- [ ] Create app in App Store Connect
- [ ] Get App Store Connect API key (or use Apple ID)
- [ ] Place `.p8` file in `credentials/` folder
- [ ] Update `eas.json` with iOS credentials
- [ ] Update bundle identifier to match App Store Connect

#### Android:
- [ ] Create app in Google Play Console
- [ ] Create service account and download JSON key
- [ ] Place `google-service-account.json` in `credentials/` folder
- [ ] Update `eas.json` with Android credentials
- [ ] Update package name to match Play Console

### Fill in Configuration Files

**1. Update `app.json`:**
```json
{
  "extra": {
    "eas": {
      "projectId": "your-actual-project-id-here"
    }
  }
}
```

Get your project ID by running: `eas build:configure`

**2. Update `eas.json`:**
```json
{
  "submit": {
    "production": {
      "ios": {
        "appleId": "your.email@example.com",
        "ascAppId": "1234567890",
        "appleTeamId": "ABCD123456"
      }
    }
  }
}
```

See [CREDENTIALS_GUIDE.md](./CREDENTIALS_GUIDE.md) for detailed instructions.

### Build and Submit

**Build:**
```bash
eas build --profile production --platform ios
eas build --profile production --platform android
```

**Submit to stores:**
```bash
eas submit --platform ios --profile production
eas submit --platform android --profile production
```

**Monitor progress:**
- Check build status: https://expo.dev
- Check submission status in App Store Connect / Play Console

---

## 📋 Files You Need to Configure

### Required Credentials (DO NOT COMMIT!)

Place these in the `credentials/` directory:

- **iOS:** `AuthKey_XXXXXXXXXX.p8` (App Store Connect API key)
- **Android:** `google-service-account.json` (Service account key)

### Configuration Files to Update

1. **app.json** - Line 48
   - Replace `YOUR_EAS_PROJECT_ID_HERE` with your actual EAS project ID

2. **eas.json** - Lines 34-36
   - Replace `YOUR_APPLE_ID_HERE` with your Apple ID
   - Replace `YOUR_ASC_APP_ID_HERE` with your App Store Connect App ID
   - Replace `YOUR_APPLE_TEAM_ID_HERE` with your Apple Team ID

---

## 🔍 Verification Checklist

Before submitting to stores, verify:

- [ ] App name is "BeMindWell" in both App Store Connect and Play Console
- [ ] Bundle ID (iOS) is `com.bemindwell.app`
- [ ] Package name (Android) is `com.bemindwell.app`
- [ ] Version is `1.0.0` in app.json
- [ ] Build numbers start at `1`
- [ ] All credentials files are in `credentials/` directory
- [ ] No credentials are committed to git (check with `git status`)
- [ ] EAS project ID is set in app.json
- [ ] Test build completes successfully
- [ ] App icons and splash screens are properly set

---

## 🆘 Common Issues

### "Invalid credentials" error
- Double-check all IDs in eas.json match your accounts
- Ensure .p8 file or service account JSON is valid
- Wait a few minutes if you just created credentials (propagation time)

### "Bundle identifier mismatch"
- Ensure `com.bemindwell.app` is registered in Apple Developer
- Check it matches exactly in app.json and App Store Connect

### "Build failed"
- Check build logs in EAS dashboard
- Ensure all dependencies are compatible
- Try a clean build: `eas build --clear-cache`

### Can't find project ID
- Run: `eas build:configure`
- Or check: https://expo.dev (your dashboard)

---

## 📚 Next Steps

1. **Development:**
   - Customize the app in the `app/` directory
   - Add your own features and screens
   - Update branding, colors, and icons

2. **Testing:**
   - Build development builds for testing
   - Share preview builds with beta testers
   - Test on real devices

3. **Publishing:**
   - Complete store listings (screenshots, descriptions)
   - Submit for review
   - Monitor review process

4. **Updates:**
   - Increment version numbers for updates
   - Use OTA updates for quick fixes (with `eas update`)
   - Submit new builds for major changes

---

## 📖 Detailed Documentation

- [README.md](./README.md) - Full documentation
- [CREDENTIALS_GUIDE.md](./CREDENTIALS_GUIDE.md) - Detailed credential setup
- [credentials/README.md](./credentials/README.md) - Quick credential reference

---

## 🎯 Summary

**To make BeMindWell ready as downloadable ZIP files:**
✅ Use `npm run create-zip` script
✅ Or download EAS builds and create ZIPs manually

**To fill in credentials for App Store publishing:**
✅ Follow [CREDENTIALS_GUIDE.md](./CREDENTIALS_GUIDE.md)
✅ Update `app.json` (EAS project ID)
✅ Update `eas.json` (Apple ID, App IDs, Team ID)
✅ Place credential files in `credentials/` directory

**Everything is ready!** Just fill in your actual credentials and you're good to go! 🚀
