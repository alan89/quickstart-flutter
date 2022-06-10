Firebase Auth Quickstart
==============================

Introduction
------------

- [Read more about Firebase Auth](https://firebase.google.com)

Getting Started
---------------

- [Add Firebase to your Flutter Project](https://firebase.google.com/docs/flutter/setup).

This example shows how to use different auth providers to login and 
signup using Firebase in a Flutter app. In order to run the example, 
you'll need to set up your Firebase console.

### Auth providers

#### Email/Password Setup

- Go to the [Firebase Console][fir-console] and navigate to your project:
    - Select the **Auth** panel and then click the **Sign In Method** tab.
    - Click **Email/Password** and turn on the **Enable** switch, then click **Save**.
    - Under **Authorized Domains** click **Add Domain** and add `auth.example.com`.

#### [Google sign in](https://firebase.google.com/docs/auth/flutter/federated-auth#google)

- Go to the [Firebase Console][fir-console] and navigate to your project:
    - Select the **Auth** panel and then click the **Sign In Method** tab.
    - Click **Add new provider** and select Google.
    - Turn on the **Enable** switch, then click **Save**.
- Include the Google sign in plugin by running this command in a terminal
  `flutter pub add google_sign_in`
- Android
    - A fingerprint will be needed. The step #3 of the "Before you begin" section in this
      [document](https://firebase.google.com/docs/auth/android/google-signin#before_you_begin) provides more information on this.
- IOS
    - A reversed client ID has to be added in the URL Schemes. Follow this [document](https://firebase.google.com/docs/auth/ios/google-signin#2_implement_google_sign-in) for reference.

#### [Facebook sign in](https://firebase.google.com/docs/auth/flutter/federated-auth#facebook)

- Go to the [Firebase Console][fir-console] and navigate to your project:
    - Select the **Auth** panel and then click the **Sign In Method** tab.
    - Click **Add new provider** and select Facebook.
    - Turn on the **Enable** switch, and add the App ID and App Secret.
    - Copy the redirect URI and then click **Save**.
    - In your Facebook app configuration, add `Facebook sign in`
    - In the settings paste the redirect URI. 
    - (Recomended) Follow the quick start guide to complete the configuration. 
    - Follow this document to update the `Facebook App ID` and `Facebook Client Token` in the app.  

#### [Apple sign in](https://firebase.google.com/docs/auth/flutter/federated-auth#apple)

As outlined in the docs, Sign in with Apple requires enabling the Sign In with Apple 
[Capability](https://developer.apple.com/documentation/xcode/adding_capabilities_to_your_app) in 
this quickstart's Xcode project.

- Go to the [Firebase Console][fir-console] and navigate to your project:
  - Select the **Auth** panel and then click the **Sign In Method** tab.
  - Click **Add new provider** and select Apple.
  - Turn on the **Enable** switch:
    - You should add the ServiceID in case you want to use this feature for a web app.
    - Add the Oauth Code Flow to support Android and Web apps. 
  - Run the app on your device (preferably).
    - NOTE: For iOS the flow is only available in physical devices
  - IN teh application, choose Apple under Identity Providers to launch the Sign in with Apple flow 
  - See the [Getting Started with Apple Sign In](https://firebase.google.com/docs/auth/ios/apple) 
guide for more details.


#### [Twitter sign in](https://firebase.google.com/docs/auth/flutter/federated-auth#twitter)

- Go to the [Firebase Console][fir-console] and navigate to your project:
  - Select the **Auth** panel and then click the **Sign In Method** tab.
  - Click **Add new provider** and select Twitter.
  - Turn on the **Enable** switch:
    - You should add your Twitter app `API Key` and `API Secret`.
  - When providing the configuration in the code, you may need to provide a schema instead of redirect URI.
    Check this [video](https://youtu.be/pQh-rskvUWA?t=967) for reference.

#### [Github sign in](https://firebase.google.com/docs/auth/flutter/federated-auth#github)

- Go to the [Firebase Console][fir-console] and navigate to your project:
  - Select the **Auth** panel and then click the **Sign In Method** tab.
  - Click **Add new provider** and select Github.
  - Turn on the **Enable** switch:
    - You should add your Twitter app `API Key` and `API Secret`.
  - The Github sign in plugin may cause Android issues. Follow this [document](https://docs.flutter.dev/development/androidx-migration)
  
### Anonymous Authentication
Start by going to the [Firebase Console](https://console.firebase.google.com) and navigate to your project:
- Select the **Auth** panel and then click the **Sign In Method** tab.
- Click **Anonymous** and turn on the **Enable** switch, then click **Save**.
- Run the app on your device or simulator.
- Choose **Anonymous Authentication**  to launch the **Anonymous Sign In** flow
  See the official [Firebase docs for anonymous authentication](https://firebase.google.com/docs/auth/flutter/anonymous-auth) for more info!

### Phone Number

When Firebase Auth uses Phone Number authentication, Auth will attempt to send a silent Apple Push Notification (APN) to the device to confirm that the phone number being used is associated with the device. If APNs (which, like Sign In with Apple, are a [capability](https://developer.apple.com/documentation/xcode/adding_capabilities_to_your_app) you can enable in Xcode or on the Apple Developer Console) are not enabled or configured correctly, Auth will instead present a web view with a reCAPTCHA verification flow.

#### Start by going to the [Firebase Console](https://console.firebase.google.com) and navigate to your project:
- Select the **Auth** panel and then click the **Sign In Method** tab.
- Click **Phone** and turn on the **Enable** switch, then click **Save**.
- Run the app on your device or simulator.
- Choose **Phone Number**  to launch the **Phone Number Authentication** flow
- After entering a phone number, please wait roughly 5 seconds to allow Firebase Auth to present the necessary flow.
  See the official [Firebase docs for phone authentication](https://firebase.google.com/docs/auth/flutter/phone-auth) for more info!

Support
-------

- [Stack Overflow](https://stackoverflow.com/questions/tagged/firebase-authentication)
- [Firebase Support](https://firebase.google.com/support/)

License
-------

Copyright 2022 Google, Inc.

Licensed to the Apache Software Foundation (ASF) under one or more contributor
license agreements.  See the NOTICE file distributed with this work for
additional information regarding copyright ownership.  The ASF licenses this
file to you under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License.  You may obtain a copy of
the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
License for the specific language governing permissions and limitations under
the License.

[fir-console]: https://console.firebase.google.com