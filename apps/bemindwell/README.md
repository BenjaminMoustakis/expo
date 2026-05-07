# BeMindWell - Mental Wellness & Mindfulness App

A comprehensive mental wellness and mindfulness application built with Expo and React Native. BeMindWell is designed to support your mental health journey through guided meditation, mood tracking, and wellness resources.

## 🌟 Features

- **Mindfulness Exercises**: Guided meditation and breathing exercises
- **Mood Tracking**: Track your emotional well-being over time
- **Wellness Resources**: Access to mental health resources and tips
- **Daily Reminders**: Set reminders for mindfulness practices
- **Progress Tracking**: Monitor your wellness journey
- **Cross-Platform**: Available on iOS, Android, and Web

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (v18 or later)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [Expo CLI](https://docs.expo.dev/get-started/installation/) - `npm install -g expo-cli`
- For iOS development: [Xcode](https://developer.apple.com/xcode/)
- For Android development: [Android Studio](https://developer.android.com/studio)

## 🚀 Getting Started

### 1. Installation

```bash
# Navigate to the app directory
cd apps/bemindwell

# Install dependencies
npm install
```

### 2. Running the App

```bash
# Start the development server
npm start

# Run on iOS simulator
npm run ios

# Run on Android emulator
npm run android

# Run on web browser
npm run web
```

## 📦 Building for Production

### Using EAS Build (Recommended)

Expo Application Services (EAS) provides cloud-based build services:

```bash
# Install EAS CLI
npm install -g eas-cli

# Login to your Expo account
eas login

# Configure the project
eas build:configure

# Build for iOS
eas build --platform ios

# Build for Android
eas build --platform android

# Build for both platforms
eas build --platform all
```

### Local Builds

For local builds, you'll need to prebuild the native projects:

```bash
# Prebuild native projects
npx expo prebuild

# Build iOS locally (requires macOS)
npx expo run:ios --configuration Release

# Build Android locally
npx expo run:android --variant release
```

## 🔑 Publishing to App Stores

### Prerequisites for Publishing

1. **iOS App Store**:
   - Active Apple Developer account ($99/year)
   - Bundle identifier: `com.bemindwell.app`
   - App Store Connect app created
   - Distribution certificate and provisioning profile

2. **Google Play Store**:
   - Google Play Developer account ($25 one-time fee)
   - Package name: `com.bemindwell.app`
   - Upload keystore and service account credentials

### Configure Credentials

1. Navigate to the `credentials` directory
2. Follow the instructions in `credentials/README.md`
3. Update `eas.json` with your credentials

### Publishing with EAS Submit

```bash
# Submit to iOS App Store
eas submit --platform ios

# Submit to Google Play Store
eas submit --platform android
```

## 📁 Project Structure

```
bemindwell/
├── app/                    # App screens and navigation (Expo Router)
├── assets/                 # Images, fonts, and other static files
├── components/            # Reusable React components
├── constants/             # App constants and configuration
├── credentials/           # Publishing credentials (DO NOT COMMIT!)
├── hooks/                 # Custom React hooks
├── scripts/               # Utility scripts
├── app.json              # Expo configuration
├── eas.json              # EAS Build configuration
├── package.json          # Dependencies and scripts
└── README.md             # This file
```

## 🔒 Security & Privacy

BeMindWell takes user privacy seriously:

- All user data is stored locally by default
- No personal information is collected without explicit consent
- Credentials and sensitive files are excluded from version control
- Follow HIPAA compliance guidelines if handling health data

## 🛠 Development

### Code Style

This project uses ESLint for code quality:

```bash
npm run lint
```

### TypeScript

The project is built with TypeScript for type safety:

```bash
# Type check
npx tsc --noEmit
```

## 📝 Environment Variables

Create a `.env` file in the root directory for environment-specific configuration:

```env
# Example environment variables
EXPO_PUBLIC_API_URL=https://api.bemindwell.com
EXPO_PUBLIC_ANALYTICS_ID=your_analytics_id
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support, please contact:
- Email: support@bemindwell.com
- Website: https://bemindwell.com

## 🙏 Acknowledgments

Built with:
- [Expo](https://expo.dev/)
- [React Native](https://reactnative.dev/)
- [React Navigation](https://reactnavigation.org/)

---

**Note**: This is a template application. Customize the content, features, and branding to match your specific requirements for the BeMindWell application.
