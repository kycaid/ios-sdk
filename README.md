# Officia KYCAID iOS SDK

![GitHub Logo](/logo/logo.png)

We are a team specialized in all KYC and Regulatory compliance matters. With us you will accelerate customer interaction, reduce risks and simplify your business processes.

## Requirements

* Xcode 11+
* iOS 13+

## Integration

KYCAID SDK is currently available via:

* [Swift Package Manager](https://swift.org/package-manager/)
* Manual drop-in of xcframework

### How to install from Xcode:

From Xcode 11, you can use Swift Package Manager to add Kingfisher to your project.
1. Select File > Swift Packages > Add Package Dependency. 
2. Enter https://github.com/onevcat/Kingfisher.git in the "Choose Package Repository" dialog.
3. In the next page, specify the version resolving rule as "Branch" with "master".
After Xcode checking out the source and resolving the version, you can choose the "KYCAID" library and add it to your app target.

![Xcode Screenshot](/logo/logo.png)

After installation, you could import Kingfisher to your project by adding this:
```swift
import KYCAIDSDK
```

### Usage

## Run verification flow

```swift
public struct KYCAID {

    /// Starts verification process by showing appropriate UI
    /// - Parameters:
    ///   - apiToken: API token. Must be obtained from dashboaed
    ///   - formId: Form identifier. Must be obtained from dashboard
    ///   - containerViewController: UIViewController which is used a contanier. KYCAID shows its UI modally using default presentation properties
    public func startVerification(apiToken: String, formId: String, containerViewController: UIViewController)
}
```

## Links

API documentation:
https://docs.kycaid.com
