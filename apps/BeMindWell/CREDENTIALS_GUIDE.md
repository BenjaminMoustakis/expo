# App Store Publishing Credentials Guide

This document provides detailed instructions for obtaining and configuring all necessary credentials for publishing BeMindWell to the iOS App Store and Google Play Store.

## Table of Contents

1. [iOS Credentials](#ios-credentials)
2. [Android Credentials](#android-credentials)
3. [Filling in eas.json](#filling-in-easjson)
4. [Filling in app.json](#filling-in-appjson)
5. [Security Best Practices](#security-best-practices)

---

## iOS Credentials

### What You Need

To publish to the iOS App Store, you need:

1. **Apple Developer Account** ($99/year)
   - Sign up at: https://developer.apple.com/programs/

2. **App Store Connect Account**
   - Access at: https://appstoreconnect.apple.com
   - Same as your Apple Developer account

3. **App Store Connect API Key** (Recommended method)
   - This is the preferred authentication method for automated builds and submissions

### Step-by-Step: Getting iOS Credentials

#### Step 1: Create App Store Connect API Key

1. Go to https://appstoreconnect.apple.com
2. Sign in with your Apple ID
3. Navigate to: **Users and Access** → **Integrations** → **App Store Connect API**
4. Click the **"+"** button to create a new key
5. Enter a name (e.g., "EAS Build Key")
6. Select access level: **App Manager** (recommended) or **Developer**
7. Click **Generate**
8. **Important:** Download the `.p8` file immediately - you can only download it once!
9. Note down:
   - **Key ID** (e.g., "2A94XP6D72")
   - **Issuer ID** (e.g., "69a6de7e-ee52-47e3-e053-5b8c7c11a4d1")

#### Step 2: Create App in App Store Connect

1. In App Store Connect, go to **My Apps**
2. Click the **"+"** button → **New App**
3. Fill in:
   - **Platform:** iOS
   - **Name:** BeMindWell
   - **Primary Language:** Your language
   - **Bundle ID:** Select or create `com.bemindwell.app`
     - If creating new: Go to https://developer.apple.com/account/resources/identifiers/list
     - Click "+" and register a new Bundle ID
   - **SKU:** A unique identifier (e.g., "bemindwell-2024")
   - **User Access:** Choose appropriate access
4. Click **Create**
5. Note down the **App ID** (numeric ID from the URL or General Information section)

#### Step 3: Find Your Apple Team ID

1. Go to https://developer.apple.com/account
2. Sign in
3. Look for **Team ID** in the top right corner or in Membership section
4. Note it down (e.g., "ABCD123456")

#### Step 4: Store iOS Credentials

1. Save the `.p8` file in `credentials/` directory:
   ```bash
   cp ~/Downloads/AuthKey_2A94XP6D72.p8 ./credentials/
   ```

2. Update `eas.json` with your credentials (see [Filling in eas.json](#filling-in-easjson))

---

## Android Credentials

### What You Need

To publish to Google Play Store, you need:

1. **Google Play Developer Account** ($25 one-time fee)
   - Sign up at: https://play.google.com/console/signup

2. **Google Play Service Account**
   - For automated builds and submissions

### Step-by-Step: Getting Android Credentials

#### Step 1: Create App in Google Play Console

1. Go to https://play.google.com/console
2. Click **Create app**
3. Fill in:
   - **App name:** BeMindWell
   - **Default language:** Your language
   - **App or game:** App
   - **Free or paid:** Choose
   - **Declarations:** Accept all required declarations
4. Click **Create app**

#### Step 2: Set Up Google Cloud Project and Service Account

1. In Google Play Console, go to **Setup** → **API access**
2. If you don't have a Google Cloud project linked:
   - Click **Link to a Google Cloud project**
   - Choose existing or create new project
3. Click **Create new service account**
4. You'll be redirected to Google Cloud Console
5. In Google Cloud Console:
   - Click **Create Service Account**
   - Name: "BeMindWell EAS Build"
   - Description: "Service account for EAS Build and Submit"
   - Click **Create and Continue**
   - Role: Select **Service Account User**
   - Click **Continue** → **Done**

#### Step 3: Create and Download Service Account Key

1. In Google Cloud Console, find your service account
2. Click on the service account email
3. Go to **Keys** tab
4. Click **Add Key** → **Create new key**
5. Choose **JSON** format
6. Click **Create**
7. The JSON file will download automatically
8. Rename it to `google-service-account.json`

#### Step 4: Grant Permissions to Service Account

1. Go back to Google Play Console → **Setup** → **API access**
2. Find your service account in the list
3. Click **Grant access**
4. Under **Account permissions**, select:
   - **Admin (all permissions)** OR
   - Specific permissions including:
     - View app information and download bulk reports
     - Manage production releases
     - Manage testing track releases
5. Click **Invite user** → **Send invitation**

#### Step 5: Store Android Credentials

1. Save the JSON file in `credentials/` directory:
   ```bash
   cp ~/Downloads/bemindwell-xxxxx-yyyyyy.json ./credentials/google-service-account.json
   ```

2. Update `eas.json` with the path (see [Filling in eas.json](#filling-in-easjson))

---

## Filling in eas.json

After obtaining all credentials, update your `eas.json` file:

### Current Template:
```json
{
  "submit": {
    "production": {
      "ios": {
        "appleId": "YOUR_APPLE_ID_HERE",
        "ascAppId": "YOUR_ASC_APP_ID_HERE",
        "appleTeamId": "YOUR_APPLE_TEAM_ID_HERE"
      },
      "android": {
        "serviceAccountKeyPath": "./credentials/google-service-account.json",
        "track": "production"
      }
    }
  }
}
```

### Fill in with YOUR values:

```json
{
  "submit": {
    "production": {
      "ios": {
        "appleId": "your.email@example.com",           // Your Apple ID email
        "ascAppId": "1234567890",                       // From App Store Connect
        "appleTeamId": "ABCD123456"                     // From Apple Developer
      },
      "android": {
        "serviceAccountKeyPath": "./credentials/google-service-account.json",
        "track": "production"                           // or "beta", "alpha", "internal"
      }
    }
  }
}
```

### Alternative: Using App Store Connect API Key (Recommended)

```json
{
  "submit": {
    "production": {
      "ios": {
        "ascApiKeyPath": "./credentials/AuthKey_2A94XP6D72.p8",
        "ascApiKeyId": "2A94XP6D72",
        "ascApiKeyIssuerId": "69a6de7e-ee52-47e3-e053-5b8c7c11a4d1",
        "ascAppId": "1234567890"
      },
      "android": {
        "serviceAccountKeyPath": "./credentials/google-service-account.json",
        "track": "production"
      }
    }
  }
}
```

---

## Filling in app.json

Update your `app.json` with the EAS project ID:

### Step 1: Get EAS Project ID

1. Login to EAS:
   ```bash
   eas login
   ```

2. Initialize project (if not already done):
   ```bash
   eas build:configure
   ```

3. The project ID will be displayed, or you can find it at:
   - https://expo.dev (your projects dashboard)
   - It's a UUID like: "a1b2c3d4-e5f6-7890-abcd-ef1234567890"

### Step 2: Update app.json

Replace `YOUR_EAS_PROJECT_ID_HERE` in `app.json`:

```json
{
  "expo": {
    ...
    "extra": {
      "eas": {
        "projectId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
      }
    }
  }
}
```

---

## Security Best Practices

### ✅ DO:

1. **Store credentials in the `credentials/` directory**
   - This directory is already gitignored

2. **Use environment variables for sensitive data**
   - Create `.env.local` for API keys
   - Never commit `.env.local` files

3. **Use App Store Connect API Keys**
   - More secure than username/password
   - Can be revoked without changing your Apple ID password

4. **Limit service account permissions**
   - Only grant necessary permissions
   - Use separate service accounts for different apps/purposes

5. **Rotate credentials regularly**
   - Generate new API keys annually
   - Update service account keys if compromised

### ❌ DON'T:

1. **Never commit credentials to git**
   - Check `.gitignore` is properly configured
   - Use `git status` before committing

2. **Never share credentials**
   - Use separate accounts for team members
   - Use App Store Connect's team features

3. **Never hardcode secrets in code**
   - Use environment variables
   - Use secure secret management

---

## Verification Checklist

Before building and submitting, verify:

- [ ] iOS:
  - [ ] Apple Developer Account is active
  - [ ] App created in App Store Connect
  - [ ] App Store Connect API key downloaded and stored
  - [ ] Bundle identifier matches in app.json and App Store Connect
  - [ ] eas.json filled with correct iOS credentials
  
- [ ] Android:
  - [ ] Google Play Developer Account is active
  - [ ] App created in Google Play Console
  - [ ] Service account created and JSON key downloaded
  - [ ] Service account has proper permissions in Play Console
  - [ ] Package name matches in app.json and Play Console
  - [ ] eas.json filled with correct Android credentials

- [ ] General:
  - [ ] EAS project ID added to app.json
  - [ ] All credentials files are in `credentials/` directory
  - [ ] `credentials/` directory is gitignored
  - [ ] No credentials committed to git

---

## Next Steps

After setting up all credentials:

1. **Test the build:**
   ```bash
   eas build --profile production --platform ios
   eas build --profile production --platform android
   ```

2. **Test the submission:**
   ```bash
   eas submit --platform ios --profile production
   eas submit --platform android --profile production
   ```

3. **Monitor the builds:**
   - Check https://expo.dev for build status
   - Review build logs for any errors

4. **Complete store listings:**
   - Add screenshots, descriptions, etc. in App Store Connect and Play Console
   - Submit for review

---

## Troubleshooting

### Common Issues:

**iOS: "Invalid Bundle Identifier"**
- Ensure bundle ID in app.json matches the one registered in Apple Developer

**iOS: "Invalid API Key"**
- Verify the Key ID and Issuer ID are correct
- Check that the .p8 file hasn't been corrupted

**Android: "Permission Denied"**
- Ensure service account has proper permissions in Play Console
- Wait a few minutes after granting permissions (can take time to propagate)

**Android: "Invalid Package Name"**
- Ensure package name in app.json matches the one in Play Console
- Package name must be unique across all Play Store apps

**EAS: "Project not found"**
- Verify the project ID in app.json is correct
- Run `eas build:configure` to ensure project is properly set up

---

## Support Resources

- **Expo EAS Documentation:** https://docs.expo.dev/eas/
- **Apple Developer Support:** https://developer.apple.com/support/
- **Google Play Support:** https://support.google.com/googleplay/android-developer/
- **Expo Forums:** https://forums.expo.dev/
- **Expo Discord:** https://chat.expo.dev/

---

## Summary

With all credentials properly configured:

✅ You can build apps using EAS Build
✅ You can submit apps to both App Store and Play Store
✅ Your credentials are secure and not committed to git
✅ You're ready to publish BeMindWell!

For detailed publishing workflow, see the main [README.md](./README.md).
