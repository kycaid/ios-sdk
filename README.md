# Official KYCAID iOS SDK

![GitHub Logo](/images/logo_new_entry.png)

## Contents

* [How to install from Xcode](#how-to-install-from-xcode)
* [How to install manually](#how-to-install-manually)
* [Setup SDK](#setup-sdk)
* [Run verification flow](#run-verification-flow)
* [Handle verification result](#handle-verification-result)
* [Handle possible errors and cancellation](#handle-possible-errors-and-cancellation)
* [Get verification status](#get-verification-status)
* [Interface customization](#customization)

## Requirements

* Xcode 11+
* iOS 13+

## Integration

KYCAID SDK is currently available via:

* [Swift Package Manager](https://swift.org/package-manager/)
* Manual drop-in of xcframework

### How to install from Xcode

From Xcode, you can use Swift Package Manager to add KYCAID to your project.
1. Select Your App Project > Package Dependencies > Add Package Dependency.
2. Enter `https://github.com/kycaid/ios-sdk` in the search box.
3. Keep the latest version or specify the version you want and click "Add package".

#### Add dependency:
![Xcode Screenshot](/images/add_package.png)
#### Select package and add to your project:
![Xcode Screenshot](/images/select_package.png)

### How to install manually

1. Download latest xcframework from [Releases](https://github.com/kycaid/ios-sdk/releases) page.
2. Drop `KYCAIDSDK.xcframework` into Frameworks, Libraries and Embedded Content section of Xcode.
3. Select "Embed and sign".

#### Add manually:
![Xcode Screenshot](/images/manual.png)

After installation, import SDK to your project by adding this:
```swift
import KYCAIDSDK
```

### Required Dependencies

You must also add the following dependencies:

- [RxSwift](https://github.com/ReactiveX/RxSwift) (`6.7.1`)
- [Lottie](https://github.com/airbnb/lottie-spm) (`4.5.1`)

## Usage

### Setup SDK

Initialize `KYCAID` instance as early as possible. 
Grab api token and form identifier from the [Dashboard](https://app.kycaid.com/dashboard)
```swift
let sdk = KYCAID(apiToken: "<YOUR API TOKEN>", formId: "<YOUR FORM ID>")
```
You can also specify the applicant ID, the color configuration and the default language in which the verification will be run.
```swift
let sdk = KYCAID(
    apiToken: "<YOUR API TOKEN>",
    formId: "<YOUR FORM ID>",
    applicantId: "<ApplicantID>",
    colorConfiguration: ...,
    languageCode: "en"
)
```
See [Interface customization](#customization) to get more details about `ColorConfiguration`.

### Run verification flow

Once you are done with the setup, you can run verification flow. You must provide content view controller, so SDK is able to show its UI.
```swift

//Interface

/// Starts verification process by showing appropriate UI
/// - Parameters:
///   - containerViewController: UIViewController which is used as a contanier. KYCAID shows its UI modally using default presentation properties.
///   - completion: Completion that helds the result. Optional
public func startVerification(containerViewController: UIViewController, completion: ((Result<KYCAIDSDK.KYCAID.VerificationInfo, Error>) -> Void)? = nil)

// Usage

sdk.startVerification(containerViewController: self) { result in
    //Handle verification result here
}
```
Basically, this is all you need to start a verification. 

As a result of this call, first verification step should appear:

<img src="/images/first_step.PNG" width="320">

Further, all required verification steps will be opened automatically, based on your form setup.

### Handle verification result

Once user done with the verification flow, the completion is invoked with `VerificationInfo` as a result
```swift
/// Result structure that is passed into verification completion
public struct VerificationInfo {

    /// Verification identifier.
    public let verificationId: String

    /// Applicant identifier. Optional. Will be nll in case of external verification.
    public let applicantId: String?

    /// Applicant info. Optional. Will be nll in case of external verification.
    public let applicantInfo: KYCAIDSDK.ApplicantInfo?
}
```

### Handle possible errors and cancellation:

If user cancels verification flow, or some error occured, the completion is invoked with `KycaidError` as a result.
```swift
sdk.startVerification(containerViewController: self) { result in
    switch result {
    case .success(let verificationInfo):
        // Handle verificationInfo
    case .failure(let error):
        switch error {
        case .cancelled:
            // Handle cancellation
        default:
            // Handle other errors
        }
    }
}
```
KycaidError:
```swift
public enum KycaidError: String, LocalizedError {
    case unauthorized = "unauthorized"
    case inactiveAccount = "inactive_account"
    case insufficientFunds = "insufficient_funds"
    case notFound = "not_found"
    case requestTimeout = "request_timeout"
    case duplicateData = "duplicate_data"
    case flow = "flow"
    case editDenied = "edit_denied"
    case deleteDenied = "delete_denied"
    case validation = "validation"
    case applicantExists = "applicant_exists"
    case verificationExists = "verification_exists"
    case insufficientData = "insufficient_data"
    case limitExceeded = "limit_exceeded"
    case internalServer = "internal_server"
    case failedToCreateVerification = "failed_to_create_verification"
    case genericError = "generic_error"
    case cancelled = "cancelled"
}
```
You can find explanation of every error in the API documentation here: https://docs.kycaid.com/#errors


### Get verification status

Once you have `verificationId` it's possible to check the verification status.
```swift
/// Checks verification state
/// - Parameters:
///   - verificationId: The identifier of the verification. See `startVerification` for details
///   - completion: Completion that helds the result
public func retrieveVerificationState(verificationId: String, completion: @escaping ((Result<KYCAIDSDK.KYCAID.VerificationState, Error>) -> Void))
```

## Customization

KYCAID SDK supports basic UI customization. 
To change UI element colors you can pass `ColorConfiguration` structure to SDK initialization:
```swift
let colorConfiguration = ColorConfiguration(<your params here>)
let sdk = KYCAID(
    apiToken: "<YOUR API TOKEN>",
    formId: "<YOUR FORM ID>",
    colorConfiguration: colorConfiguration
)
```
ColorConfiguration properties:
```swift
public struct ColorConfiguration {
    
    /// Background color of the screens being presented
    public let backgroundColor: UIColor
    
    /// Main color of the SDK. It’s used for high-emphasis interactive elements like:
    /// - action buttons (e.g., “Continue”, “Submit”)
    /// - active elements (e.g., selected items, active radio buttons)
    /// - progress indicators
    /// - hyperlinks
    public let primaryColor: UIColor
    
    /// Secondary color of the SDK. It’s used for lower-priority elements:
    /// - secondary action buttons
    /// - icons or borders for secondary elements
    /// - labels with lower emphasis
    /// - selection indication in the list
    public let secondaryColor: UIColor
    
    /// Color of the content (e.g. text, icons) placed in UI elements which have `secondaryColor` as a background color
    public let onSecondaryColor: UIColor
    
    /// Background color for surfaces, containers, or elevated elements. Usually used for popups, modals, bottom sheets
    public let surfaceColor: UIColor
    
    /// Color of the content (e.g. text, icons) placed in UI elements which have `surfaceColor` as a background color
    public let onSurfaceColor: UIColor
    
    /// Color used as a background color for cards (rectangles with rounded corners containing some UI elements)
    public let cardBackgroundColor: UIColor
    
    /// Primary text color
    public let textPrimaryColor: UIColor
    
    /// Secondary text color
    public let textSecondaryColor: UIColor
    
    /// Border color of normal text field
    public let textfieldBorderColor: UIColor
    
    /// Border color of disabled text field
    public let disabledTextfieldBorderColor: UIColor
    
    /// Border color of focused text field
    public let focusedTextfieldBorderColor: UIColor
    
    /// Placeholder color in text fields
    public let textfieldPlaceholderColor: UIColor
    
    /// Background color of the navigation bar
    public let navigationBarColor: UIColor
    
    /// Text color in the navigation bar
    public let navigationBarTextColor: UIColor
    
    /// Background color of normal buttons
    public let buttonBackgroundColor: UIColor
    
    /// Background color of disabled buttons
    public let disabledButtonBackgroundColor: UIColor
    
    /// Text color in normal buttons
    public let buttonTextColor: UIColor
    
    /// Text color in disabled buttons
    public let disabledButtonTextColor: UIColor
    
    /// Border color of outlined buttons
    public let outlinedButtonBorderColor: UIColor
    
    /// Text color in outlined buttons
    public let outlinedButtonTextColor: UIColor
    
    /// Color for pending indication
    public let pendingColor: UIColor
    
    /// Color for success indication
    public let successColor: UIColor
    
    /// Color for error indication
    public let errorColor: UIColor
}
```
Note that each property has its default value, so you can change only those you need.

**Example**
<p float="center">
    <img src="/images/colors_1.PNG" width="240">
    <img src="/images/colors_2.PNG" width="240">
</p>
<p float="center">
    <img src="/images/colors_3.PNG" width="240">
    <img src="/images/colors_4.PNG" width="240">
</p>

## Notes

SDK uses Camera and Photos Library to make photo verification possible, so next entries shold be added to the `Info.plist` of your application:

```
"NSCameraUsageDescription" = "Camera permission is required to create verifications";
"NSPhotoLibraryUsageDescription" = "Library permission is required to create verifications";

```
#### Info.plist:
![Xcode Screenshot](/images/info_plist.png)

## Screenshots

<p float="center">
  <img src="/images/screenshots/1.PNG" width="240" />
  <img src="/images/screenshots/2.PNG" width="240" /> 
  <img src="/images/screenshots/3.PNG" width="240" />
</p>
<p float="center">
  <img src="/images/screenshots/4.PNG" width="240" />
  <img src="/images/screenshots/5.PNG" width="240" /> 
  <img src="/images/screenshots/6.PNG" width="240" />
</p>
<p float="center">
  <img src="/images/screenshots/7.PNG" width="240" />
  <img src="/images/screenshots/8.PNG" width="240" /> 
  <img src="/images/screenshots/9.PNG" width="240" />
</p>
<p float="center">
  <img src="/images/screenshots/10.PNG" width="240" />
  <img src="/images/screenshots/11.PNG" width="240" /> 
  <img src="/images/screenshots/12.PNG" width="240" />
</p>

## Localization

KYCAID SDK supports following languages:

* English
* Azeybarjan
* Brunei
* German
* Spanish
* Spanish (Mexico)
* French
* French (Canada)
* Hindi
* Croatian
* Hebrew
* Yiddish
* Kazakh
* Dutch
* Polish
* Portuguese
* Portuguese (Brazil)
* Romanian
* Russian
* Serbian
* Tajik
* Turkish
* Ukrainian
* Uzbek
* Chinese
* Indonesian
* Georgian
* Malay
* Thai
* Vietnamese

## Links

API documentation:
https://docs.kycaid.com
