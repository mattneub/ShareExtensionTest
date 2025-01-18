## ShareExtensionTest

This little project is meant as a demo to show how some apps are able to accept multiple photos from the Photos app and _switch to the app itself_.

To test, you might need to rejigger the app group and entitlements in some way. Then run the app on your device, from Xcode, and switch to the Photos app. Select a photo and tap the Share button; then select one or two more photos. Now find this app (ShareExtensionTest) in the list of target apps in the share sheet, and tap it. There will be short pause and then we will automatically _switch to the app_ (ShareExtensionTest), and logging will show that the correct number of images has been found.

This app doesn't actually _do_ anything with the images; that's up to you.
