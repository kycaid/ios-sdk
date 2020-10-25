# Official KYCAID iOS SDK

![GitHub Logo](/logo/logo.png)

## Requirements

* Xcode 11+
* iOS 13+

## Integration

KYCAID SDK is currently available via:

* [Swift Package Manager](https://swift.org/package-manager/)
* Manual drop-in of xcframework

### How to install from Xcode

From Xcode 11, you can use Swift Package Manager to add Kingfisher to your project.
1. Select File > Swift Packages > Add Package Dependency. 
2. Enter https://github.com/onevcat/Kingfisher.git in the "Choose Package Repository" dialog.
3. In the next page, specify the version resolving rule as "Branch" with "master".
After Xcode checking out the source and resolving the version, you can choose the "KYCAID" library and add it to your app target.

![Xcode Screenshot](/logo/logo.png)

### How to install manually

1. Download latest xcframework from [Releases](https://github.com/kycaid/ios-sdk/releases) page.
2. Drop `KYCAIDSDK.xcframework` into Frameworks, Libraries and Embedded Content section of Xcode.
3. Select "Embed and sign".

![Xcode Screenshot](/logo/logo.png)

After installation, you could import Kingfisher to your project by adding this:
```swift
import KYCAIDSDK
```

## Usage

### Setup SDK

Initialize `KYCAID` instance as early as possible. 
Grab api token and form identifier from the [Dashboard](https://kycaid.com/dashboard)
```swift
let sdk = KYCAID(apiToken: "<YOUR API TOKEN>", formId: "<YOUR FORM ID>")
```

### Run verification flow

Once you are done with the setup, you can run verification flow. You must provide content view controller, so SDK is able to show its UI.
```swift

//Interface

/// Starts verification process by showing appropriate UI
/// - Parameters:
///   - apiToken: API token. Must be obtained from dashboard
///   - formId: Form identifier. Must be obtained from dashboard
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

<img src="/logo/country.png" width="360">

Further, all required verification steps are about to be open automatically, based on your form setup.

For now SDK supported states are:

```swift
public enum ViewState {

    /// Initial state nothing is happening
    case initial

    /// Form is being loaded
    case formLoading

    /// Coutry selection scree
    case countrySelect

    /// Choose verification type screen
    case verificationType

    /// Browser screen
    case browser

    /// Document type screen
    case documentType

    /// Document info screen
    case documentInfo

    /// Selfie screen
    case selfie

    /// Profile screen
    case profile

    /// Verification is being created screen
    case inProgress

    /// Verification result screen
    case verificationResult

    /// Verficiation success screen
    case verificationSuccess
}
```
They must be look like this:
<img src="/logo/license.png" width="360">
<img src="/logo/photo.png" width="360">
<img src="/logo/profile.png" width="360">


## Localization

KYCAID SDK Supports:

* English
* Ukrainian
* Russian

## Links

API documentation:
https://docs.kycaid.com
