# KYCAID-iOS

![GitHub Logo](/logo/logo.png)

We are a team specialized in all KYC and Regulatory compliance matters. With us you will accelerate customer interaction, reduce risks and simplify your business processes.

## SDK

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

Production:
https://docs.kycaid.com

Staging site: 
https://stg.kycaid.com

Staging API:
https://stg-api.kycaid.com

API documentation:
https://docs.google.com/document/d/1iPcKhGNkn-u9toxYJXvtria0qfYO4Aaqq1vC2BjlLqg/edit
