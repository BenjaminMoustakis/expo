# Credentials Directory

This directory should contain the following files for App Store publishing:

## iOS Credentials

### For App Store Connect API:
- `AuthKey_XXXXXXXXXX.p8` - Your App Store Connect API Key file
  - Get this from: https://appstoreconnect.apple.com/access/integrations/api
  - Key ID and Issuer ID needed in eas.json

### Alternative (using Apple ID):
You can also use your Apple ID credentials directly, but API keys are recommended.

## Android Credentials

### For Google Play Store:
- `google-service-account.json` - Your Google Play Service Account key
  - Get this from: https://play.google.com/console/
  - Go to Setup → API access → Create new service account
  - Download the JSON key file

## Important Notes

⚠️ **NEVER commit these credential files to git!**

The `.gitignore` file is already configured to exclude this directory.

## Setting up Credentials

### iOS:
1. Go to https://appstoreconnect.apple.com/access/integrations/api
2. Create a new API Key with App Manager access
3. Download the .p8 file
4. Save it in this credentials directory
5. Update eas.json with:
   - `ascApiKeyPath`: Path to your .p8 file
   - `ascApiKeyId`: Your Key ID
   - `ascApiKeyIssuerId`: Your Issuer ID
   - `ascAppId`: Your App Store Connect App ID

### Android:
1. Go to Google Play Console
2. Setup → API access
3. Create a service account
4. Grant "Release Manager" permissions
5. Download the JSON key
6. Save it as `google-service-account.json` in this directory

## EAS Build Configuration

After setting up credentials, you can build using:

```bash
# Development build
eas build --profile development --platform ios
eas build --profile development --platform android

# Production build
eas build --profile production --platform ios
eas build --profile production --platform android
```

## Submitting to App Stores

```bash
# Submit to App Store
eas submit --platform ios --profile production

# Submit to Google Play
eas submit --platform android --profile production
```
