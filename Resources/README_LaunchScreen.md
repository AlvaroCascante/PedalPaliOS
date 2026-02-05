LaunchScreen.storyboard

I added `LaunchScreen.storyboard` to this folder which displays the `mobi_bike_logo` image centered on a system background.

Steps to enable it in Xcode (one of these methods):

1) Target settings (recommended):
   - In Xcode select your app target `PedalPal` -> General tab -> "App Icons and Launch Images" -> set "Launch Screen File" to `LaunchScreen` (without extension).

2) Info.plist (alternate):
   - Open your target Info.plist and set the key `UILaunchStoryboardName` to the string `LaunchScreen`.

Notes:
- Make sure the `mobi_bike_logo` asset exists in your app Asset Catalog and is named exactly `mobi_bike_logo`.
- The launch screen is static and displayed by iOS while the app loads. If you need animations or to wait for initialization, present a SwiftUI `SplashView` from your `App` entry (this project already includes `SplashView` / `PedalPalApp.swift`).
- If you use asset catalogs with vector PDFs, ensure "Preserve Vector Data" is enabled for correct rendering.

Testing:
- Test a cold launch (quit the app, then run) on Simulator and device to verify the system launch screen appears.
- If you don't see the image, confirm the Launch Screen File is configured and the asset name matches.
