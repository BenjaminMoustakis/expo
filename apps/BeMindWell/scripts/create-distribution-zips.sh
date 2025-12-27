#!/bin/bash

# BeMindWell - Create Distribution ZIP Files
# This script helps create ZIP files for distribution

set -e

VERSION=$(node -p "require('./package.json').version")
APP_NAME="BeMindWell"

echo "================================================"
echo "  BeMindWell Distribution ZIP Creator"
echo "  Version: $VERSION"
echo "================================================"
echo ""

# Create dist directory if it doesn't exist
mkdir -p dist

# Function to create source code ZIP
create_source_zip() {
    echo "Creating source code ZIP..."
    ZIP_NAME="dist/${APP_NAME}-Source-v${VERSION}.zip"
    
    # Create ZIP excluding build artifacts and dependencies
    zip -r "$ZIP_NAME" . \
        -x "node_modules/*" \
        -x ".expo/*" \
        -x "dist/*" \
        -x "web-build/*" \
        -x ".git/*" \
        -x "ios/*" \
        -x "android/*" \
        -x "*.log" \
        -x ".DS_Store" \
        -x "credentials/*.json" \
        -x "credentials/*.p8" \
        -x "credentials/*.p12" \
        -x "credentials/*.key" \
        -x "credentials/*.pem"
    
    echo "✓ Source code ZIP created: $ZIP_NAME"
    echo ""
}

# Function to create web build ZIP
create_web_zip() {
    echo "Creating web build ZIP..."
    
    # Check if web-build exists
    if [ ! -d "web-build" ]; then
        echo "Web build not found. Building web version..."
        npx expo export:web
    fi
    
    ZIP_NAME="dist/${APP_NAME}-Web-v${VERSION}.zip"
    cd web-build
    zip -r "../$ZIP_NAME" .
    cd ..
    
    echo "✓ Web build ZIP created: $ZIP_NAME"
    echo ""
}

# Function to download and ZIP EAS builds
download_eas_builds() {
    echo "================================================"
    echo "  EAS Build Download Instructions"
    echo "================================================"
    echo ""
    echo "To create distribution ZIPs from EAS builds:"
    echo ""
    echo "1. Build your app:"
    echo "   eas build --profile production --platform ios"
    echo "   eas build --profile production --platform android"
    echo ""
    echo "2. Download the build artifacts from EAS dashboard:"
    echo "   https://expo.dev"
    echo ""
    echo "3. Create ZIPs manually:"
    echo "   zip -r ${APP_NAME}-iOS-v${VERSION}.zip /path/to/downloaded/app.ipa"
    echo "   zip -r ${APP_NAME}-Android-v${VERSION}.zip /path/to/downloaded/app.aab"
    echo ""
    echo "Or use the EAS CLI to download:"
    echo "   eas build:list"
    echo "   eas build:download --platform ios"
    echo "   eas build:download --platform android"
    echo ""
}

# Main menu
echo "What would you like to create?"
echo ""
echo "1) Source code ZIP (for developers)"
echo "2) Web build ZIP"
echo "3) Show EAS build instructions"
echo "4) All of the above"
echo "5) Exit"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        create_source_zip
        ;;
    2)
        create_web_zip
        ;;
    3)
        download_eas_builds
        ;;
    4)
        create_source_zip
        create_web_zip
        download_eas_builds
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac

echo "================================================"
echo "  Distribution files created in 'dist/' folder"
echo "================================================"
echo ""
echo "Created ZIPs:"
ls -lh dist/*.zip 2>/dev/null || echo "No ZIP files created yet"
echo ""
