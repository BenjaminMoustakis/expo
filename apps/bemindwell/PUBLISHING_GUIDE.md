# BeMindWell Publishing Guide

This guide provides step-by-step instructions for publishing the BeMindWell app to the Apple App Store and Google Play Store.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Preparing for iOS App Store](#preparing-for-ios-app-store)
3. [Preparing for Google Play Store](#preparing-for-google-play-store)
4. [Building the App](#building-the-app)
5. [Testing Builds](#testing-builds)
6. [Submitting to App Stores](#submitting-to-app-stores)
7. [Post-Launch Checklist](#post-launch-checklist)

## Prerequisites

### General Requirements
- [ ] Completed BeMindWell app development
- [ ] Tested app thoroughly on both iOS and Android
- [ ] Prepared app assets (icons, screenshots, descriptions)
- [ ] Created privacy policy and terms of service
- [ ] Set up Expo account: https://expo.dev

### Install Required Tools
```bash
# Install Node.js (v18 or later)
# Download from: https://nodejs.org/

# Install Expo CLI
npm install -g expo-cli

# Install EAS CLI
npm install -g eas-cli
```

## Preparing for iOS App Store

### Step 1: Apple Developer Account Setup
1. **Enroll in Apple Developer Program**
   - Visit: https://developer.apple.com/programs/
   - Cost: $99/year
   - Complete enrollment process (may take 24-48 hours)

2. **Gather Required Information**
   - Apple ID (your developer account email)
   - Apple Team ID (found in your account settings)
   - App Store Connect access

### Step 2: Create App ID in Apple Developer Portal
1. Log in to https://developer.apple.com/account/
2. Navigate to "Certificates, Identifiers & Profiles"
3. Click on "Identifiers" → "+" button
4. Select "App IDs" and click "Continue"
5. Configure:
   - Description: `BeMindWell`
   - Bundle ID: `com.bemindwell.app` (Explicit)
   - Capabilities: Enable as needed (e.g., Push Notifications, HealthKit if needed)
6. Click "Continue" and "Register"

### Step 3: Generate Certificates and Provisioning Profiles

**Option A: Automatic (Recommended with EAS)**
EAS Build can automatically handle certificates and profiles:
```bash
eas build --platform ios
# Follow prompts to let EAS manage credentials
```

**Option B: Manual Setup**
1. **Create Distribution Certificate:**
   - In Apple Developer Portal → Certificates
   - Click "+" → Select "iOS Distribution"
   - Follow CSR generation instructions
   - Download the certificate (.cer file)
   - Convert to .p12:
     ```bash
     # In Keychain Access (Mac only)
     # Export certificate as .p12 file with a password
     ```

2. **Create Distribution Provisioning Profile:**
   - In Apple Developer Portal → Profiles
   - Click "+" → Select "App Store"
   - Select your App ID
   - Select your distribution certificate
   - Download the profile (.mobileprovision)

### Step 4: Create App in App Store Connect
1. Log in to https://appstoreconnect.apple.com/
2. Click "My Apps" → "+" → "New App"
3. Configure:
   - Platform: iOS
   - Name: BeMindWell
   - Primary Language: English
   - Bundle ID: com.bemindwell.app
   - SKU: bemindwell-001 (unique identifier)
4. Click "Create"
5. Note the **App Store Connect App ID** (found in App Information)

### Step 5: Update eas.json with iOS Credentials
Edit `eas.json`:
```json
{
  "submit": {
    "production": {
      "ios": {
        "appleId": "your.apple.id@example.com",
        "ascAppId": "1234567890",
        "appleTeamId": "ABCD123456"
      }
    }
  }
}
```

## Preparing for Google Play Store

### Step 1: Google Play Developer Account Setup
1. **Create Developer Account**
   - Visit: https://play.google.com/console/signup
   - Cost: $25 (one-time fee)
   - Complete verification process

2. **Create Application**
   - In Google Play Console, click "Create app"
   - App name: BeMindWell
   - Default language: English
   - App or game: App
   - Free or paid: Select as appropriate
   - Complete declarations and click "Create app"

### Step 2: Generate Android Keystore
Run this command to create a keystore:
```bash
keytool -genkeypair -v -storetype JKS -keyalg RSA -keysize 2048 \
  -validity 10000 -alias bemindwell-key \
  -keystore credentials/bemindwell-upload-key.jks
```

When prompted, enter:
- Keystore password: (choose a strong password)
- Key password: (can be same as keystore password)
- First and last name: Your organization name
- Organizational unit: Your team name
- Organization: Your company name
- City/Locality: Your city
- State/Province: Your state
- Country code: Your country (e.g., US)

**IMPORTANT**: Store these securely!
- Keystore file location
- Keystore password
- Key alias: `bemindwell-key`
- Key password

### Step 3: Create Service Account for Google Play
1. **Create Service Account in Google Cloud Console**
   - Go to https://console.cloud.google.com/
   - Create a new project or select existing
   - Navigate to "IAM & Admin" → "Service Accounts"
   - Click "Create Service Account"
   - Name: `bemindwell-play-publisher`
   - Click "Create and Continue"
   - Skip granting roles (will do in Play Console)
   - Click "Done"

2. **Create JSON Key**
   - Click on the service account you just created
   - Go to "Keys" tab
   - Click "Add Key" → "Create new key"
   - Select JSON format
   - Click "Create"
   - Save the downloaded JSON file to:
     `credentials/google-play-service-account.json`

3. **Link Service Account to Google Play Console**
   - In Google Play Console, go to "Setup" → "API access"
   - Click "Link" to link your Google Cloud project
   - Under "Service accounts", find your service account
   - Click "Grant access"
   - Select permissions: "Admin (all permissions)"
   - Click "Invite user" → "Send invitation"

### Step 4: Configure Package Name
Ensure `app.json` has the correct package name:
```json
{
  "expo": {
    "android": {
      "package": "com.bemindwell.app"
    }
  }
}
```

## Building the App

### Step 1: Configure EAS Build
If not already done:
```bash
cd bemindwell
eas build:configure
```

### Step 2: Build for Production

**iOS Build:**
```bash
eas build --platform ios --profile production
```

**Android Build:**
```bash
eas build --platform android --profile production
```

**Build Both Platforms:**
```bash
eas build --platform all --profile production
```

The build process will:
1. Upload your code to EAS servers
2. Install dependencies
3. Generate native code
4. Compile the application
5. Sign the app with your credentials
6. Provide download links for the builds

**Build times**: 10-30 minutes depending on platform

## Testing Builds

### iOS TestFlight
1. After build completes, download the .ipa file or use EAS Submit
2. In App Store Connect, go to your app → TestFlight
3. Upload build (or use `eas submit --platform ios`)
4. Add internal testers
5. Share with beta testers via email or public link

### Android Internal Testing
1. After build completes, download the .aab file
2. In Google Play Console, go to your app → Internal testing
3. Create a new release
4. Upload the .aab file
5. Add internal testers (via email list)
6. Roll out to internal testing track

## Submitting to App Stores

### iOS App Store Submission

**Step 1: Complete App Store Connect Information**
1. In App Store Connect, go to your app
2. Fill in all required information:
   - App Information (category, content rating)
   - Pricing and Availability
   - App Privacy (privacy policy URL)
   - Screenshots (required for all devices)
   - App Previews (optional videos)
   - Promotional Text
   - Description
   - Keywords
   - Support URL
   - Marketing URL (optional)

**Step 2: Submit Build**
```bash
eas submit --platform ios --profile production
```

Or manually in App Store Connect:
1. Go to App Store → iOS App section
2. Click "+" next to Build
3. Select your build from TestFlight
4. Complete all required fields
5. Click "Submit for Review"

**Step 3: Wait for Review**
- Review typically takes 24-48 hours
- You'll receive email updates on review status
- Address any issues if rejected

### Google Play Store Submission

**Step 1: Complete Store Listing**
In Google Play Console:
1. Store presence → Main store listing:
   - App name
   - Short description (80 chars)
   - Full description (4000 chars)
   - App icon (512x512 PNG)
   - Feature graphic (1024x500)
   - Screenshots (at least 2)
   - App category
   - Contact details

2. Store presence → Store settings:
   - App category
   - Tags
   - Contact details

3. Policy → App content:
   - Complete all declarations
   - Privacy policy URL
   - Content ratings questionnaire
   - Target audience and content
   - News apps declaration (if applicable)
   - COVID-19 contact tracing (if applicable)
   - Data safety form

**Step 2: Create Production Release**
```bash
eas submit --platform android --profile production
```

Or manually:
1. In Google Play Console → Production
2. Click "Create new release"
3. Upload the .aab file
4. Enter release notes
5. Click "Review release"
6. Click "Start rollout to Production"

**Step 3: Review Process**
- Google Play review typically faster than iOS (hours to days)
- App will be available once approved

## Post-Launch Checklist

### Immediate Actions
- [ ] Verify app is live in both stores
- [ ] Test downloading and installing from stores
- [ ] Monitor crash reports and analytics
- [ ] Respond to user reviews
- [ ] Monitor app performance metrics

### Marketing
- [ ] Announce launch on social media
- [ ] Send email to mailing list
- [ ] Update website with store links
- [ ] Create press kit/media materials
- [ ] Reach out to tech press/bloggers

### Ongoing Maintenance
- [ ] Monitor user feedback and ratings
- [ ] Track bugs and feature requests
- [ ] Plan update schedule
- [ ] Keep dependencies updated
- [ ] Monitor app store guidelines for changes

## App Store URLs

After publishing, your app will be available at:

**Apple App Store:**
```
https://apps.apple.com/app/id{APP_STORE_CONNECT_APP_ID}
```

**Google Play Store:**
```
https://play.google.com/store/apps/details?id=com.bemindwell.app
```

## Troubleshooting Common Issues

### iOS Build Failures
- **Missing credentials**: Run `eas credentials` to configure
- **Certificate expired**: Renew in Apple Developer Portal
- **Build timeout**: Check for circular dependencies or large assets

### Android Build Failures
- **Keystore issues**: Verify keystore path and passwords
- **Google Play signing**: Enable Google Play App Signing
- **Version conflicts**: Ensure version codes are incrementing

### Submission Rejections

**iOS Common Reasons:**
- Crashes or bugs
- Missing features mentioned in description
- Privacy policy issues
- Design guideline violations

**Android Common Reasons:**
- Missing privacy policy
- Incomplete content rating
- Permissions not justified
- Data safety form incomplete

## Additional Resources

- [Expo Documentation](https://docs.expo.dev/)
- [EAS Build Documentation](https://docs.expo.dev/build/introduction/)
- [EAS Submit Documentation](https://docs.expo.dev/submit/introduction/)
- [Apple App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Google Play Policy Center](https://play.google.com/about/developer-content-policy/)
- [Expo Forums](https://forums.expo.dev/)
- [Expo Discord](https://chat.expo.dev/)

---

**Good luck with your app launch! 🚀**

If you need help, check the Expo documentation or reach out to the Expo community.
