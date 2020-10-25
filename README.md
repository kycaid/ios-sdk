# Officia KYCAID iOS SDK

![GitHub Logo](/logo/logo.png)

We are a team specialized in all KYC and Regulatory compliance matters. With us you will accelerate customer interaction, reduce risks and simplify your business processes.

## Requirements

* Xcode 11+
* iOS 13+

## Integration

KYCAID SDK is currently available via:

* [Swift Package Manager](/asda/asd)
* Manual drop-in of xcframework

### Installation Guide.

SPRM

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
