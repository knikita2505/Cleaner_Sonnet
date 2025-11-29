# Info.plist Configuration Guide

## Required Permission Usage Descriptions

Since this project uses modern Xcode configuration, you need to add the following permission usage descriptions to your **Info.plist** or **project target settings**.

### Method 1: Add to Info.plist (if exists)

If your project has an `Info.plist` file, add these keys:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photos to detect duplicates, similar photos, large videos and help you free up storage space.</string>

<key>NSContactsUsageDescription</key>
<string>We need access to your contacts to help merge duplicates, remove empty entries, and store private contacts securely.</string>
```

### Method 2: Add via Xcode Target Settings (Recommended for modern projects)

1. Open **Cleaner_Sonnet.xcodeproj** in Xcode
2. Select the **Cleaner_Sonnet** target in the project navigator
3. Go to the **Info** tab
4. Click the **+** button under "Custom iOS Target Properties"
5. Add the following entries:

#### Photo Library Usage
- **Key**: `Privacy - Photo Library Usage Description`  
  (or raw: `NSPhotoLibraryUsageDescription`)
- **Type**: String
- **Value**: `We need access to your photos to detect duplicates, similar photos, large videos and help you free up storage space.`

#### Contacts Usage  
- **Key**: `Privacy - Contacts Usage Description`  
  (or raw: `NSContactsUsageDescription`)
- **Type**: String
- **Value**: `We need access to your contacts to help merge duplicates, remove empty entries, and store private contacts securely.`

## Verification

After adding these keys:
1. Build the project (⌘+B)
2. Run on simulator/device
3. When permission screens appear, tap "Continue"
4. You should see the **system permission dialogs** with your custom messages
5. The message in the system dialog should match the description you added

## Troubleshooting

### App crashes when requesting permission
- **Cause**: Missing usage description
- **Fix**: Make sure you added the keys correctly in Xcode

### System dialog shows generic message
- **Cause**: Wrong key name or not rebuilt
- **Fix**: Clean build folder (⌘+Shift+K) and rebuild (⌘+B)

### Permission already denied
- **Fix**: Go to Settings app → Cleaner_Sonnet → Reset permissions, or delete and reinstall the app
