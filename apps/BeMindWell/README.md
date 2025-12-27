# BeMindWell

A React Native mobile application built with Expo for iOS and Android platforms.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Building for Production](#building-for-production)
- [Creating Downloadable ZIP Files](#creating-downloadable-zip-files)
- [Publishing to App Stores](#publishing-to-app-stores)
- [Configuration](#configuration)

## Overview

BeMindWell is a universal mobile application built using:
- **Expo SDK** - For cross-platform development
- **React Native** - For native mobile UI
- **Expo Router** - For navigation
- **TypeScript** - For type safety

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (version 18 or later)
- **npm** or **yarn**
- **Expo CLI**: Install globally with `npm install -g expo-cli`
- **EAS CLI**: Install globally with `npm install -g eas-cli`

### For iOS Development:
- macOS with Xcode installed
- Apple Developer Account ($99/year)

### For Android Development:
- Android Studio (optional, for local builds)
- Google Play Developer Account ($25 one-time fee)

## Getting Started

### 1. Install Dependencies

```bash
npm install
```

### 2. Start Development Server

```bash
npm start
```

This will start the Expo development server. You can then:
- Press `i` to open iOS simulator
- Press `a` to open Android emulator
- Scan the QR code with Expo Go app on your physical device

### 3. Other Development Commands

```bash
npm run ios       # Start iOS simulator
npm run android   # Start Android emulator
npm run web       # Start web version
npm run lint      # Run linter
```

## Building for Production

### Initial Setup

1. **Create an Expo account** at https://expo.dev
2. **Login to EAS**:
   ```bash
   eas login
   ```

3. **Initialize EAS Build**:
   ```bash
   eas build:configure
   ```

4. **Update EAS Project ID**:
   - After running `eas build:configure`, update the `extra.eas.projectId` in `app.json` with your project ID

### Building the App

#### Development Build (for testing):
```bash
eas build --profile development --platform ios
eas build --profile development --platform android
```

#### Preview Build (internal distribution):
```bash
eas build --profile preview --platform ios
eas build --profile preview --platform android
```

#### Production Build (for app stores):
```bash
eas build --profile production --platform ios
eas build --profile production --platform android
```

### Build Outputs

After a successful build, EAS will provide:
- A download link for the build artifact
- Build logs and details
- QR code for easy installation (for development/preview builds)

## Creating Downloadable ZIP Files

### Method 1: Using EAS Build (Recommended)

After building with EAS, you'll receive download links for your builds:

**For iOS:**
- Development/Preview: `.tar.gz` file containing the `.app` bundle
- Production: `.ipa` file ready for App Store submission

**For Android:**
- Development/Preview: `.apk` file
- Production: `.aab` (Android App Bundle) file

**To create a ZIP:**
```bash
# Download the build artifact from EAS
# Then create a ZIP file
zip -r BeMindWell-iOS-v1.0.0.zip /path/to/downloaded/artifact.ipa
zip -r BeMindWell-Android-v1.0.0.zip /path/to/downloaded/artifact.aab
```

### Method 2: Local Export

For web builds or source distribution:

```bash
# Export the web build
npx expo export:web

# Create a ZIP of the web-build directory
zip -r BeMindWell-Web-v1.0.0.zip web-build/
```

**For source code distribution:**
```bash
# Create a ZIP of the entire project (excluding node_modules and build artifacts)
zip -r BeMindWell-Source-v1.0.0.zip . -x "node_modules/*" ".expo/*" "dist/*" "web-build/*" ".git/*" "ios/*" "android/*"
```

## Publishing to App Stores

### Prerequisites: Set Up Credentials

See [credentials/README.md](./credentials/README.md) for detailed instructions on setting up:
- iOS: App Store Connect API keys
- Android: Google Play Service Account

### Configure eas.json

Update the following placeholders in `eas.json`:

**For iOS:**
```json
"ios": {
  "appleId": "your.apple.id@email.com",
  "ascAppId": "1234567890",
  "appleTeamId": "ABCD123456"
}
```

**For Android:**
```json
"android": {
  "serviceAccountKeyPath": "./credentials/google-service-account.json",
  "track": "production"
}
```

### iOS: App Store Connect Setup

1. **Create App in App Store Connect:**
   - Go to https://appstoreconnect.apple.com
   - Click "My Apps" → "+" → "New App"
   - Fill in app information:
     - Platform: iOS
     - Name: BeMindWell
     - Primary Language: Choose your language
     - Bundle ID: `com.bemindwell.app`
     - SKU: A unique identifier (e.g., `bemindwell-2024`)

2. **Fill in App Information:**
   - App Privacy
   - Screenshots (required: 6.5", 5.5" displays)
   - Description
   - Keywords
   - Support URL
   - Marketing URL (optional)

3. **Submit for Review:**
   ```bash
   eas submit --platform ios --profile production
   ```

### Android: Google Play Console Setup

1. **Create App in Google Play Console:**
   - Go to https://play.google.com/console
   - Click "Create app"
   - Fill in app details:
     - App name: BeMindWell
     - Default language
     - App or Game: App
     - Free or Paid: Choose
     - Accept declarations

2. **Complete Store Listing:**
   - App details
   - Graphics (icon, feature graphic, screenshots)
   - Categorization
   - Contact details
   - Privacy policy

3. **Set Up Content Rating:**
   - Complete the questionnaire

4. **Submit for Review:**
   ```bash
   eas submit --platform android --profile production
   ```

## Configuration

### App Configuration (app.json)

Key configuration fields in `app.json`:

```json
{
  "expo": {
    "name": "BeMindWell",
    "slug": "bemindwell",
    "version": "1.0.0",
    "ios": {
      "bundleIdentifier": "com.bemindwell.app",
      "buildNumber": "1"
    },
    "android": {
      "package": "com.bemindwell.app",
      "versionCode": 1
    }
  }
}
```

**Important Fields:**
- `version`: User-facing version (e.g., "1.0.0")
- `ios.buildNumber`: Must increment with each build
- `android.versionCode`: Must increment with each build
- `ios.bundleIdentifier`: Must match App Store Connect
- `android.package`: Must match Google Play Console

### Environment Variables

Create a `.env.local` file for sensitive data:

```env
# API keys and secrets
API_URL=https://api.example.com
API_KEY=your_api_key_here
```

**Note:** This file is gitignored and won't be committed.

## Troubleshooting

### Build Failures

If builds fail:
1. Check the build logs in EAS dashboard
2. Ensure all dependencies are compatible with Expo SDK version
3. Verify credentials are properly configured

### Submission Failures

If app submission fails:
1. Verify bundle identifier (iOS) or package name (Android) matches
2. Ensure all required metadata is filled in the store console
3. Check that build profile matches submission profile

## Resources

- [Expo Documentation](https://docs.expo.dev)
- [EAS Build Documentation](https://docs.expo.dev/build/introduction)
- [EAS Submit Documentation](https://docs.expo.dev/submit/introduction)
- [App Store Connect Help](https://developer.apple.com/app-store-connect)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)

## License

MIT

## Support

For issues or questions, please contact the development team or create an issue in the repository.
