# Integrate **Kycaid Native SDK** into a Flutter App (No Plugin)

This guide explains how **your Flutter team** can call the **native Kycaid SDK** on **Android** and **iOS** using a small MethodChannel bridge. No Flutter plugin is required; you’ll add a few lines of native code inside the existing Flutter app.

At the end, you’ll trigger Kycaid SDK from Dart with:

```dart
final result = await KycaidSdk.startVerification();
```

---

## Table of Contents

1. [Dart bridge](#dart-bridge)  
2. [Android integration](#android-integration)  
   - [A. Add Maven repo & dependency](#a-add-maven-repo--dependency)  
   - [B. Wire the MethodChannel and launch the SDK](#b-wire-the-methodchannel-and-launch-the-sdk)  
3. [iOS integration](#ios-integration)  
   - [A. Add the SDK (SPM / XCFramework)](#a-add-the-sdk-spm--xcframework)  
   - [B. Additional dependencies](#b-additional-dependencies)
   - [C. Wire the MethodChannel and launch the SDK](#c-wire-the-methodchannel-and-launch-the-sdk-1)
4. [Configuration: tokens, environment, language, theme](#configuration-tokens-environment-language-theme)

---

## Dart bridge

Create `lib/kycaid_sdk.dart`:

```dart
import 'package:flutter/services.dart';

class KycaidSdk {
  static const _channel = MethodChannel('kycaid_sdk');

  /// Starts the native Kycaid verification flow.
  /// There's no args because the sdk will be configured in the native part
  /// Note: It's up to you to decide how to handle the result from the sdk but note that `MethodChannel` supports only primitive types.
  static Future<Map<String, dynamic>?> startVerification() async {
    final res = await _channel.invokeMethod('startKycaidVerification');
    return (res as Map?)?.cast<String, dynamic>();
  }
}
```

Usage example:

```dart
final result = await KycaidSdk.startVerification();
```

---

## Android integration

> You are going to work with files that located in `android/` in your Flutter project. Before you start, it's recommended to open `android` folder in Android Studio. This will allow you to see hints and make it easier for you to work with native code in general. But this is not mandatory.

### A. Add Maven repo & dependency

**`android/settings.gradle(.kts)`** (Kotlin DSL)

```kotlin
pluginManagement {
    ..
    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()
        maven("https://nexus.kycaid.com/repository/android")
    }
}
..
```

**`android/build.gradle.kts`** (Kotlin DSL)
```kotlin
allprojects {
    repositories {
        google()
        mavenCentral()
        maven("https://nexus.kycaid.com/repository/android")
    }
}
```
Add the dependency in **`android/app/build.gradle.kts`** (Kotlin DSL)
```kotlin
plugins {
    ..
}

android {
    ..
}

dependencies {
    implementation("com.kycaid:kycaid-sdk:25.8.0.0")
}
```
If you use **Groovy Gradle plugin** (without **`.kts`** extension), the syntax is a bit different:
```Groovy
maven { url 'https://nexus.kycaid.com/repository/android' }
implementation 'com.kycaid:kycaid-sdk:25.8.0.0'
```
> **Important:** Add the dependency **only** in `:app`. Do **not** put it in root or any non-Android module.

### B. Wire the MethodChannel and launch the SDK

**`android/app/src/main/kotlin/<your package>/MainActivity.kt`**

```kotlin
package <your package>

import android.content.Intent
import com.kycaid.sdk.api.KycaidConfiguration
import com.kycaid.sdk.api.KycaidEnvironment
import com.kycaid.sdk.api.KycaidIntent
import com.kycaid.sdk.api.KycaidResult
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val channelName = "kycaid_sdk"
    private var resultHandler: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            if (call.method == "startKycaidVerification") {
                resultHandler = result
                val config = KycaidConfiguration.Builder("<your API Token>", "<your Form ID>")
                    .applicantId("<your Applicant ID (optional)>")
                    .build()
                val intent = KycaidIntent(config)
                intent.startActivityForResult(this)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        KycaidIntent.onActivityResult(requestCode, resultCode, data) { result ->
            /// This is an example of how you can handle the result. You can write any logic you want here.
            when (result) {
                is KycaidResult.Success -> resultHandler?.success(mapOf("success" to result.toString()))
                is KycaidResult.Failure -> resultHandler?.success(mapOf("failure" to result.toString()))
                is KycaidResult.Cancelled -> resultHandler?.success(mapOf("cancelled" to result.toString()))
            }
            resultHandler = null
        }
    }
}
```

---

## iOS integration

> Open `ios/Runner.xcworkspace` in Xcode.

### A. Add the SDK (SPM / XCFramework)

> There are two ways of the KYCAID SDK installation on iOS: through Swift Pacakge Manager and manual drag-and-drop of the `KYCAIDSDK.xcframework` file. Choose what suits you best.

**Swift Package Manager (recommended)**  
- Xcode → **File → Add Package Dependencies**  
- Enter the [Kycaid iOS SDK package URL](https://github.com/kycaid/ios-sdk), select the latest version, add to **Runner** target.

![Xcode Screenshot](/images/select_package.png)

**XCFramework**  
- Download latest xcframework from [Releases](https://github.com/kycaid/ios-sdk/releases) page.
- Drag-and-drop `KYCAIDSDK.xcframework` into `Runner` target in Xcode (check **Copy items if needed**).
- Target **Runner → General → Frameworks, Libraries, and Embedded Content** → set **Embed & Sign**.

![Xcode Screenshot](/images/manual.png)

### B. Additional dependencies

You must also add the following dependencies:

- [RxSwift](https://github.com/ReactiveX/RxSwift) (`6.7.1`) – RxSwift and RxRelay packages only
- [Lottie](https://github.com/airbnb/lottie-spm) (`4.5.1`)

> You can add them in the same way as KYCAID SDK.

### C. Wire the MethodChannel and launch the SDK

**`ios/Runner/AppDelegate.swift`**

```swift
import Flutter
import UIKit
import KYCAIDSDK

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let flutterVC = window.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "kycaid_sdk", binaryMessenger: flutterVC.binaryMessenger)
      
      channel.setMethodCallHandler { call, result in
          guard call.method == "startKycaidVerification" else {
              result(FlutterMethodNotImplemented)
              return
          }
          
          let sdk = KYCAID(
            apiToken: "<your API Token>",
            formId: "<your Form ID>",
            applicantId: "<your Applicant ID (optional)>"
          )
          sdk.startVerification(containerViewController: flutterVC) { kycaidResult in
              /// This is an example of how you can handle the result. You can write any logic you want here.
              switch kycaidResult {
              case .success(let success):
                  result(["success": "\(success)"])
              case .failure(let failure):
                  result(["failure": "\(failure)"])
              }
          }
      }
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## Configuration: tokens, environment, language, theme

It's best to build the configuration **natively** in Android’s `MainActivity` and iOS’s `AppDelegate`. Thus you don't need to pass complicated data structures represented in `Map` through `MethodChannel`.

To see more details about the SDK configuration and setup, you can refer to the official documentation:
- Android: https://github.com/kycaid/android-sdk/blob/master/README.md
- iOS: https://github.com/kycaid/ios-sdk/blob/master/README.md
