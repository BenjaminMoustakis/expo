# BeMindWell App - Downloadable Package

## 📦 Overview

This repository now contains the **BeMindWell** mental wellness application - a complete, production-ready Expo/React Native app that can be published to the Apple App Store and Google Play Store.

## 🎯 Quick Access

### Option 1: Use the Pre-Built Package (Recommended)

A downloadable zipfile has been created at:
```
apps/bemindwell/dist/BeMindWell_v1.0.0_[timestamp].zip
```

**To use this package:**
1. Download the zip file from the `apps/bemindwell/dist/` directory
2. Extract it to your desired location
3. Follow the instructions in the included `SETUP.md` file

### Option 2: Work Directly from the Repository

The source code is available at:
```
apps/bemindwell/
```

**To use from the repository:**
```bash
cd apps/bemindwell
npm install
npm start
```

## 📁 What's Included

The BeMindWell package contains:

- ✅ **Complete App Source Code** - Production-ready React Native/Expo application
- ✅ **App Store Configuration** - Pre-configured for iOS App Store (`com.bemindwell.app`)
- ✅ **Google Play Configuration** - Pre-configured for Google Play (`com.bemindwell.app`)
- ✅ **Publishing Credentials Setup** - Templates and guides for both stores
- ✅ **Comprehensive Documentation** - Step-by-step guides for everything
- ✅ **Packaging Scripts** - Create distribution zips anytime

## 📚 Documentation

Inside the package, you'll find:

| Document | Description |
|----------|-------------|
| **SUMMARY.md** | Quick overview of the package contents |
| **PACKAGE_INFO.md** | Detailed package information and guide |
| **README.md** | Complete app development documentation |
| **PUBLISHING_GUIDE.md** | Step-by-step publishing instructions |
| **credentials/README.md** | Credential setup for App Store and Google Play |

## 🚀 Quick Start

```bash
# 1. Navigate to the app
cd apps/bemindwell

# 2. Install dependencies
npm install

# 3. Start development
npm start

# 4. To create a fresh distribution package
npm run package
```

## 📱 Publishing to App Stores

### Prerequisites

1. **Apple Developer Account** - $99/year (for iOS)
2. **Google Play Developer Account** - $25 one-time (for Android)

### Steps

1. Follow the **PUBLISHING_GUIDE.md** in the package
2. Set up credentials as described in **credentials/README.md**
3. Use EAS Build to create production builds
4. Submit to both stores using EAS Submit

**Total cost to publish**: $124

## 🛠 Technology Stack

- **Framework**: Expo SDK 54
- **Language**: TypeScript
- **Platforms**: iOS, Android, Web
- **Build Service**: EAS Build
- **Navigation**: Expo Router

## 📦 Creating a Distribution Package

You can create a fresh distribution package anytime:

**On Unix/Linux/Mac:**
```bash
cd apps/bemindwell
npm run package
```

**On Windows:**
```bash
cd apps\bemindwell
npm run package:windows
```

The package will be created in `apps/bemindwell/dist/`

## 🎨 Customization

The app is ready to use as-is, but you can customize:

- **App Name**: Edit `app.json`
- **Bundle IDs**: Edit `app.json` (iOS and Android sections)
- **Colors/Theme**: Edit `constants/theme.ts`
- **App Icon**: Replace files in `assets/images/`
- **Content**: Modify screens in `app/` directory

## 🔒 Security

The package follows security best practices:

- ✅ No credentials committed to version control
- ✅ Template files for sensitive data
- ✅ `.gitignore` configured to protect secrets
- ✅ Environment variable support

## 📖 Learning Resources

- [Expo Documentation](https://docs.expo.dev/)
- [React Native Documentation](https://reactnative.dev/)
- [EAS Build Documentation](https://docs.expo.dev/build/introduction/)

## ✨ Features

The BeMindWell app is designed for mental wellness and includes:

- Cross-platform support (iOS, Android, Web)
- Modern UI with theme support
- File-based routing with Expo Router
- TypeScript for type safety
- Ready for App Store submission
- Ready for Google Play submission

## 🆘 Getting Help

1. Check the documentation files in the package
2. Visit [Expo Forums](https://forums.expo.dev/)
3. Join [Expo Discord](https://chat.expo.dev/)

## ✅ Package Contents Summary

```
bemindwell/
├── app/                    # Application screens
├── assets/                 # Images, icons, fonts
├── components/            # Reusable UI components
├── constants/             # App configuration
├── credentials/           # Publishing credential templates
├── hooks/                 # Custom React hooks
├── scripts/               # Utility scripts
│   ├── package-app.sh    # Create zip (Unix/Mac)
│   └── package-app.bat   # Create zip (Windows)
├── app.json              # Expo configuration
├── eas.json              # EAS Build configuration
├── package.json          # Dependencies
├── README.md             # Main documentation
├── PACKAGE_INFO.md       # Package guide
├── PUBLISHING_GUIDE.md   # Publishing instructions
└── SUMMARY.md            # Quick summary
```

## 🎊 Next Steps

1. **Download** the zipfile from `apps/bemindwell/dist/`
2. **Extract** to your preferred location
3. **Read** SETUP.md for quick start
4. **Develop** and customize as needed
5. **Publish** using the publishing guide
6. **Launch** your app! 🚀

---

**The BeMindWell app is ready for download and deployment!**

For the complete experience, download the zipfile from `apps/bemindwell/dist/` - it contains everything you need in a single, portable package.
