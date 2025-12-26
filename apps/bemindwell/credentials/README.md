# BeMindWell Credentials Configuration

This directory contains template files and placeholders for the credentials needed to publish BeMindWell to the App Store and Google Play.

## iOS Credentials (App Store)

### Required Files:
1. **Apple Developer Account**
   - Apple ID: Your Apple developer account email
   - Apple Team ID: Found in your Apple Developer account
   - App Store Connect App ID: Created in App Store Connect

2. **Certificates and Provisioning Profiles**
   - Distribution Certificate (.p12 file)
   - Distribution Provisioning Profile (.mobileprovision file)
   - Push Notification Certificate (if using push notifications)

### Setup Instructions:
1. Enroll in the Apple Developer Program ($99/year)
2. Create an App ID in the Apple Developer portal with bundle identifier: `com.bemindwell.app`
3. Generate a Distribution Certificate
4. Create a Distribution Provisioning Profile
5. Create an app in App Store Connect
6. Update `eas.json` with your Apple credentials

## Android Credentials (Google Play)

### Required Files:
1. **Google Play Console Account**
   - Developer account ($25 one-time fee)
   - Service Account Key (JSON file)

2. **Keystore**
   - Upload key (.jks file)
   - Key password
   - Keystore password
   - Key alias

### Setup Instructions:
1. Create a Google Play Developer account
2. Create a new application in Google Play Console with package name: `com.bemindwell.app`
3. Generate a keystore file:
   ```bash
   keytool -genkeypair -v -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 \
     -alias bemindwell-key -keystore bemindwell-upload-key.jks
   ```
4. Create a service account in Google Cloud Console
5. Download the service account key JSON file
6. Grant the service account necessary permissions in Google Play Console

## EAS Build Credentials

When using EAS Build, credentials can be managed automatically:

```bash
# Let EAS manage your credentials
eas build --platform ios
eas build --platform android

# Or manually upload credentials
eas credentials
```

## Security Notes

⚠️ **IMPORTANT**: Never commit actual credential files to version control!

- Add credential files to `.gitignore`
- Store credentials securely (use a password manager or secure vault)
- Use environment variables for sensitive data when possible
- Rotate credentials periodically
- Limit access to credentials to authorized team members only

## File Placeholders

Place your actual credential files here:
- `ios-distribution-cert.p12` - iOS distribution certificate
- `ios-distribution-profile.mobileprovision` - iOS provisioning profile
- `google-play-service-account.json` - Google Play service account key
- `bemindwell-upload-key.jks` - Android keystore file

## Additional Resources

- [Expo EAS Build Documentation](https://docs.expo.dev/build/introduction/)
- [iOS App Distribution Guide](https://developer.apple.com/distribute/)
- [Google Play Publishing Guide](https://developer.android.com/studio/publish)
