# Official KYCAID iOS SDK

![GitHub Logo](/images/logo.png)

## Contents

* [Integration](#integration)
    - [How to install from Xcode](#how-to-install-from-xcode)
    - [How to install manually](#how-to-install-manually)
    - [SDK Dependencies](#sdk-dependencies)
* [Usage](#usage)
    - [Setup SDK](#setup-sdk)
    - [Run verification flow](#run-verification-flow)
    - [Handle verification result](#handle-verification-result)
    - [Handle possible errors and cancellation](#handle-possible-errors-and-cancellation)
    - [Get verification status](#get-verification-status)
* [NFC document verification](#nfc-document-verification)
    - [Install the NFC module](#install-the-nfc-module)
    - [Configure capabilities and Info.plist](#configure-capabilities-and-infoplist)
    - [Enable NFC feature](#enable-nfc-feature)
* [Analytics](#analytics)
* [UI customization](#ui-customization)
* [Useful notes](#notes)
* [Screenshots](#screenshots)
* [Localization](#localization)
* [Useful links](#links)

## Requirements

* Xcode 13+
* iOS 15+

## Integration

> If you are working with [Flutter](https://docs.flutter.dev/), you can take a look at this [quick guide](https://github.com/kycaid/ios-sdk/blob/master/Flutter%20Integration%20Guide.md) to integrating the KYCAID SDK into a Flutter app.

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

### SDK Dependencies

KYCAID SDK depends on following libraries:

- [Lottie](https://github.com/airbnb/lottie-spm) (`4.5.2`)

If you are using SPM to add the sdk to your project, you don't need to add all these dependencies manually; they should be **resolved automatically**.
> However, if for some reason this didn't happen, or you manually added `KYCAIDSDK.xcframework` to your project, please add all these dependencies manually via SPM.

## Usage

### Setup SDK

#### By API Token and Form ID:
Initialize `KYCAID` instance as early as possible. 
Grab api token and form identifier from the [Dashboard](https://app.kycaid.com/dashboard)
```swift
let sdk = KYCAID(apiToken: "<YOUR API TOKEN>", formId: "<YOUR FORM ID>")
```
You can also specify already existing applicant ID, external applicant ID, environment, color configuration and default language.
```swift
let sdk = KYCAID(
    apiToken: "<YOUR API TOKEN>",
    formId: "<YOUR FORM ID>",
    applicantId: "<Applicant ID>",
    externalApplicantId: "<External Applicant ID>",
    environment: <Environment>,
    language: "<Language>",
    theme: <KycaidTheme>,
    showsCompleteButtonAtLastStep: <Bool>
)
```

`apiToken` – authorization token obtained from the dashboard

`formId` – ID of the verification form obtained from the dashboard

`applicantId` – ID of the already existing applicant. Default value: `nil`, it means that fresh applicant will be created

`externApplicantId` – ID of the external applicant, needed for binding the external applicant to the applicant created in the KYCAID system. Default value: `nil`

`environment` – flag which determines which API will be used, `stg-api` or `api`, that is staging or production environment. Default value: `production`

`language` – the language in which the form will be run by default. Default value: `nil`

`theme` – SDK theme, intended for UI customisation. See [UI customization](#ui-customization) to get more details about `KycaidTheme`

`showsCompleteButtonAtLastStep` – whether a complete button should be shown on the verification status screen. `false` by default.

#### By Form Token:
If you don't want to hold `apiToken` and `formId` in your app, then you can initialize `KYCAID` with `formToken`, which you must obtain yourself using this endpoint: https://docs.kycaid.com/api/forms/form-get-url.
```swift
let sdk = KYCAID(formToken: "<FORM TOKEN>")
```
> Note: if you want to run a form for a specific applicant, you should pass `applicant_id` in the `form-get-url` request body so that the applicant is linked to the form. Otherwise new applicant will be created.

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
    // Handle verification result here
}
```
Basically, this is all you need to start a verification. 

As a result of this call, first verification step should appear:

<img src="/images/screenshots/1.PNG" width="320">

Further, all required verification steps will be opened automatically, based on your form setup.

### Handle verification result

Once user done with the verification flow, the completion is invoked with `VerificationInfo` as a result
```swift
/// Result structure that is passed into verification completion
struct VerificationInfo {
    
    /// Verification identifier.
    public let verificationId: String
    
    /// Applicant identifier. Optional. Will be nll in case of external verification.
    public let applicantId: String?
    
    /// Applicant info. Optional. Will be nll in case of external verification.
    public let applicantInfo: ApplicantInfo?
    
    /// Current verification status at the time of closing the SDK
    public let currentVerificationStatus: VerificationStatus
}

/// Represents the verification status
enum VerificationStatus {
    case pending, customerPending, approved, declined
}
```

### Handle possible errors and cancellation

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
    case forbiddenDuplicatesRetries = "forbidden_duplicates_retries"
    case forbiddenAgeRestrictedRetries = "forbidden_age_restricted_retries"
    case forbiddenCountryRestrictedRetries = "forbidden_country_restricted_retries"
    case forbiddenCompromisedPersonRetries = "forbidden_compromised_person_retries"
    case forbiddenFakeDocumentRetries = "forbidden_fake_document_retries"
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
You can find explanation of every error in the API documentation here: https://docs-v1.kycaid.com/#errors


### Get verification status

Once you have `verificationId` it's possible to check the verification status.
```swift
/// Checks verification state
/// - Parameters:
///   - verificationId: The identifier of the verification. See `startVerification` for details
///   - completion: Completion that helds the result
public func retrieveVerificationState(verificationId: String, completion: @escaping ((Result<KYCAIDSDK.KYCAID.VerificationState, Error>) -> Void))
```
This method returns `VerificationState` which contains the verification status and the verification steps with their particular statuses:
```swift
/// Represents the verification state
struct VerificationState {
    
    /// Represents the type of verification step
    public enum VerificationType: String {
        case profile = "profile"
        case document = "document"
        case questionnaire = "questionnaire"
        case facial = "facial"
        case taxId = "tax_id"
        case address = "address"
        case sourceOfFunds = "aml"
        case videoQuiz = "video"
        case liveVideo = "live_video"
        case paymentMethod = "payment_method"
        case databaseScreening = "database_screening"
        case qes = "qes"
        case undefined = "undefined"
    }
    
    /// State of the concrete verification step
    public struct Verification {
        public let type: VerificationType
        public let status: VerificationStatus
        public let comment: String?
        public let declineReasons: [DeclineReason]
    }
    
    /// Reasons why a verification has been declined
    public enum DeclineReason: String, Codable {
        case other, wrongName, wrongDob, ageRestriction, expiredDocument, badQuality, fakeDocument,
             wrongInfo, prohibitedJurisdiction, noSelfie, differentFaces, wrongDocument, duplicate,
             documentDamaged, documentIncomplete, fraudulent, taxIdRequired, compromisedPerson, editedDocument,
             multiplePerson, compulsion, limitReachedOtp, ipMismatch, anonymizingNetwork, qesMismatch, debtor
    }
    
    /// Verification identifier
    public let verificationId: String
    
    /// Identifier of the applicant who is being verified
    public let applicantId: String
    
    /// Overall verification status. Possible values: pending, customerPending, approved, declined
    public let status: VerificationStatus
    
    /// States of the concrete verification steps
    public let verifications: [Verification]
}
```

## NFC document verification

If your verification form includes documents with an embedded RFID chip (biometric passports and some ID cards), the SDK can read that chip over NFC and cross-check the data on the chip against the recognised document. This gives you a much stronger guarantee that the document is genuine and hasn't been tampered with.

NFC verification support is shipped as a separate `KYCAIDSDKNFC` module that supplements the main `KYCAIDSDK`. It's optional: if you don't add and enable it, the SDK simply runs the verification flow without the NFC step. This keeps your app size unaffected unless you actually opt in — the NFC module and its dependencies are only pulled in when you add the `KYCAIDSDKNFC` product.

> NFC reading only works on a physical device with NFC hardware (iPhone 7 and newer). It is not available in the simulator.

### Install the NFC module

The NFC module is distributed alongside the main SDK, so no new package URL is needed.

#### From Xcode (Swift Package Manager)

1. Add the package as described in [How to install from Xcode](#how-to-install-from-xcode) (or open the already added `https://github.com/kycaid/ios-sdk` package).
2. In the products list, select **both** `KYCAIDSDK` and `KYCAIDSDKNFC` and add them to your app target.

#### Manually

1. Download the latest `KYCAIDSDK.xcframework` and `KYCAIDSDKNFC.xcframework` from the [Releases](https://github.com/kycaid/ios-sdk/releases) page.
2. Drop both into the Frameworks, Libraries and Embedded Content section of Xcode and select "Embed and sign".
3. The NFC module depends on [OpenSSL](https://github.com/krzyzanowskim/OpenSSL-Package), so add it too. If you install via SPM this dependency is **resolved automatically**; when installing manually you have to add `OpenSSL.xcframework` yourself.

### Configure capabilities and Info.plist

NFC reading requires a few project settings. Without them the OS won't allow the SDK to start an NFC session.

1. In your app target, open **Signing & Capabilities**, add the **Near Field Communication Tag Reading** capability and enable “Pace” and “Tag” options. This adds the following entitlement to your app:
```xml
<key>com.apple.developer.nfc.readersession.formats</key>
<array>
    <string>TAG</string>
    <string>PACE</string>
</array>
```
2. Add a usage description string to your `Info.plist`:
```
"NFCReaderUsageDescription" = "To validate that the data on the document matches the data on its chip";
```
3. Declare the application identifiers (AIDs) the SDK selects on the chip in your `Info.plist`:
```xml
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
    <string>A0000002471001</string>
</array>
```

### Enable NFC feature

The main SDK module doesn't contain NFC feature on its own. To enable it, call `KycaidNfc.register()` once before you start a verification, for example at app launch:
```swift
import KYCAIDSDKNFC

KycaidNfc.register()
```
Once registered, whenever the verification flow reaches a document that has an NFC chip, the SDK automatically offers the NFC scanning step. If you skip this call, the SDK keeps working normally but without NFC reading.

> Note: the NFC scanning step is shown only when **all** of the following hold:
> - NFC verification is enabled for the document step of your form on the [Dashboard](https://app.kycaid.com/dashboard);
> - the recognised document actually has a readable NFC chip;
> - the `KYCAIDSDKNFC` product is added, `KycaidNfc.register()` is called, and the capabilities and `Info.plist` entries above are in place.
>
> If any of these is missing, the verification flow continues normally, just without the NFC verification step.

## Analytics

In case you need to gather analytics about user actions during the verification flow, you can use `KYCAID.AnalyticsListener` interface to subscribe to analytics events coming from the SDK:
```swift
class MyAnalyticsListener: KYCAID.AnalyticsListener {
    
    func onEvent(_ event: String, params: [String : Any]) {
        // Handle those events as you wish, for example, send them to your Firebase Analytics.
    }
}

let sdk = KYCAID(
    apiToken: "<YOUR API TOKEN>",
    formId: "<YOUR FORM ID>",
    analyticsListener: MyAnalyticsListener()
)
```

## UI customization

KYCAID SDK supports basic UI customization. You can specify a huge amount of colors for UI elements of the SDK. All you need is build KycaidTheme with help of KycaidThemeBuilder like this:
```swift
let customTheme = KycaidThemeBuilder()
    .colorScheme(.init(
        backgroundColor: .gray,
        primaryColor = .yellow,
        textPrimaryColor = .blue,
        textSecondaryColor = .cyan
    ))
    .build()
let sdk = KYCAID(
    apiToken: "<YOUR API TOKEN>",
    formId: "<YOUR FORM ID>",
    theme: customTheme
)
```
Here are all the colors you can change:
```swift
public struct KycaidTheme {
    
    public let colorScheme: ColorScheme
    public let cardColors: CardColors
    public let textFieldColors: TextFieldColors
    public let dropdownColors: DropdownColors
    public let multiSelectColors: MultiSelectColors
    public let radioButtonColors: RadioButtonColors
    public let checkBoxColors: CheckBoxColors
    public let navigationBarColors: NavigationBarColors
    public let buttonColors: ButtonColors
    public let outlinedButtonColors: OutlinedButtonColors
    public let documentTypeButtonColors: DocumentTypeButtonColors
    public let alertDialogColors: AlertDialogColors
    
    public struct ColorScheme {
        /// The main background color used for screens.
        public let backgroundColor: UIColor?
        
        /// The primary brand color used for major UI elements and key actions such as:
        /// - action buttons (e.g., “Continue”, “Submit”)
        /// - active elements (e.g., selected and focused elements, radio buttons and check boxes)
        /// - progress indicators
        /// - hyperlinks
        /// - cursor color in text fields
        /// - checkmarks (e.g. on the verification status screen)
        /// - countdown timers (e.g. during the document preprocessing)
        /// **Unless it's not overridden by component-specific colors**
        public let primaryColor: UIColor?
        
        /// The color used for text and icons displayed on top of `primaryColor` backgrounds.
        public let onPrimaryColor: UIColor?
        
        /// The secondary accent color, used to highlight secondary actions or elements,
        /// such as selection indication in dropdown lists (e.g. language dropdown list).
        public let secondaryColor: UIColor?
        
        /// The color used for text and icons displayed on top of `secondaryColor` backgrounds.
        public let onSecondaryColor: UIColor?
        
        /// The tertiary accent color, intended for decorative elements such as the stars in the instructions.
        public let tertiaryColor: UIColor?
        
        /// Background color for surfaces and elevated elements. Usually used for dropdown lists.
        public let surfaceColor: UIColor?
        
        /// The color used for text and icons displayed on top of `surfaceColor` backgrounds.
        public let onSurfaceColor: UIColor?
        
        /// The color used for borders of primary elements such as:
        /// - cards
        /// - text fields
        /// - radio buttons
        /// - check boxes
        /// - other elements that have border
        /// **Unless it's not overridden by component-specific colors**
        public let primaryBorderColor: UIColor?
        
        /// The primary text color used for most text in the SDK.
        public let textPrimaryColor: UIColor?
        
        /// The secondary text color used for supporting or less prominent text, such as instructions, subtitles, error descriptions.
        public let textSecondaryColor: UIColor?
        
        /// The color used for hyperlink text and interactive links.
        /// Defaults to `primaryColor` unless explicitly specified.
        public let hyperlinkColor: UIColor?
        
        /// The color used to indicate pending statuses.
        public let pendingColor: UIColor?
        
        /// The color used to indicate successful statuses.
        public let successColor: UIColor?
        
        /// The color used to indicate errors, failures, or negative statuses.
        public let errorColor: UIColor?
        
        /// The color used for divider lines between content and control elements,
        /// such as the divider between the document info and the "Submit" button.
        public let dividerColor: UIColor?
    }
    
    public struct CardColors {
        /// The background color of cards and card-like surfaces.
        public let backgroundColor: UIColor?
        
        /// The border color of cards.
        /// Defaults to `primaryBorderColor` unless explicitly specified.
        public let borderColor: UIColor?
        
        /// The color used for text and icons displayed on cards.
        public let onCardColor: UIColor?
    }
    
    public struct TextFieldColors {
        /// The background color of text fields.
        public let backgroundColor: UIColor?
        
        /// The border color of text fields.
        /// Defaults to `primaryBorderColor` unless explicitly specified.
        public let borderColor: UIColor?
        
        /// The color of entered text in text fields.
        public let textColor: UIColor?
        
        /// The color of placeholder in text fields.
        public let placeholderColor: UIColor?
        
        /// The color of the text cursor in text fields.
        /// Defaults to `primaryColor` unless explicitly specified.
        public let cursorColor: UIColor?
        
        /// The color of the label above text fields,  dropdowns, check boxes, radio buttons and other input fields
        public let labelColor: UIColor?
        
        /// The background color of disabled text fields.
        public let disabledBackgroundColor: UIColor?
        
        /// The border color of disabled text fields.
        public let disabledBorderColor: UIColor?
        
        /// The color of entered text in disabled text fields.
        public let disabledTextColor: UIColor?
        
        /// The color of placeholder in disabled text fields.
        public let disabledPlaceholderColor: UIColor?
        
        /// The border color of focused text fields.
        /// Defaults to `primaryColor` unless explicitly specified.
        public let focusedBorderColor: UIColor?
    }
    
    public struct DropdownColors {
        /// The background color of the dropdown button (the view that triggers the list showing).
        public let backgroundColor: UIColor?
        
        /// The border color of the dropdown button.
        /// Defaults to `primaryBorderColor` unless explicitly specified.
        public let borderColor: UIColor?
        
        /// The color of text in the dropdown button.
        public let textColor: UIColor?
        
        /// The color of placeholder in the dropdown button.
        public let placeholderColor: UIColor?
        
        /// The tint color for the dropdown arrow icon.
        public let arrowTintColor: UIColor?
        
        /// The border color of the focused dropdown button.
        /// Defaults to `primaryColor` unless explicitly specified.
        public let focusedBorderColor: UIColor?
    }

    public struct MultiSelectColors {
        /// Colors of the multi-select trigger view (the view that opens the options list).
        /// Mirrors the dropdown trigger styling.
        /// Each value defaults to the matching `DropdownColors` value unless explicitly specified.
        public let trigger: DropdownColors

        /// Colors of the selected option tags shown below the trigger view.
        public let tag: TagColors

        public init(
            trigger: DropdownColors = DropdownColors(),
            tag: TagColors = TagColors()
        ) {
            self.trigger = trigger
            self.tag = tag
        }

        public struct TagColors {
            /// The background color of a selected option tag.
            public let backgroundColor: UIColor?

            /// The border color of a selected option tag.
            /// Defaults to `primaryColor` unless explicitly specified.
            public let borderColor: UIColor?

            /// The color of text and the remove icon inside a selected option tag.
            /// Defaults to `primaryColor` unless explicitly specified.
            public let textColor: UIColor?

            public init(
                backgroundColor: UIColor? = nil,
                borderColor: UIColor? = nil,
                textColor: UIColor? = nil
            ) {
                self.backgroundColor = backgroundColor
                self.borderColor = borderColor
                self.textColor = textColor
            }
        }
    }
    
    public struct RadioButtonColors {
        /// The background color of radio buttons.
        public let backgroundColor: UIColor?
        
        /// The border color of radio buttons.
        /// Defaults to `primaryBorderColor` unless explicitly specified.
        public let borderColor: UIColor?
        
        /// The color of text labels associated with radio buttons.
        public let textColor: UIColor?
        
        /// The tint color applied to the radio button indicator.
        /// Defaults to `primaryColor` unless explicitly specified.
        public let buttonTintColor: UIColor?
    }
    
    public struct CheckBoxColors {
        /// The background color of checkboxes.
        public let backgroundColor: UIColor?
        
        /// The border color of checkboxes.
        /// Defaults to `primaryBorderColor` unless explicitly specified.
        public let borderColor: UIColor?
        
        /// The color of text labels associated with checkboxes.
        public let textColor: UIColor?
        
        /// The tint color applied to the checkbox checkmark (when it's checked).
        /// Defaults to `primaryColor` unless explicitly specified.
        public let buttonTintColor: UIColor?
    }
    
    public struct NavigationBarColors {
        /// The background color of the navigation bar (or top bar).
        public let backgroundColor: UIColor?
        
        /// The border color of the navigation bar.
        public let borderColor: UIColor?
        
        /// The color of the title (step label) in the navigation bar.
        public let titleColor: UIColor?
        
        /// The color of the subtitle (step description) in the navigation bar.
        public let subtitleColor: UIColor?
        
        /// The tint color for the back button icon in the navigation bar.
        public let backButtonTintColor: UIColor?
        
        /// The tint color for the language icon in the navigation bar.
        public let languageButtonTintColor: UIColor?
    }
    
    public struct ButtonColors {
        /// The background color of normal buttons.
        /// Defaults to `primaryColor` unless explicitly specified.
        public let backgroundColor: UIColor?
        
        /// The color of text and icons in normal buttons.
        /// Defaults to `onPrimaryColor` unless explicitly specified.
        public let textColor: UIColor?
        
        /// The background color of disabled buttons.
        /// Defaults to `backgroundColor` with alpha 0.4 unless explicitly specified.
        public let disabledBackgroundColor: UIColor?
        
        /// The color of text and icons in disabled buttons.
        public let disabledTextColor: UIColor?
    }
    
    public struct OutlinedButtonColors {
        /// The background color of outlined buttons.
        /// Transparent by default unless explicitly specified.
        public let backgroundColor: UIColor?
        
        /// The border color of outlined buttons.
        /// Defaults to `textPrimaryColor` unless explicitly specified.
        public let borderColor: UIColor?
        
        /// The color of text and icons in outlined buttons.
        /// Defaults to `textPrimaryColor` unless explicitly specified.
        public let textColor: UIColor?
    }
    
    public struct DocumentTypeButtonColors {
        /// The background color of document type selection buttons.
        public let backgroundColor: UIColor?
        
        /// The border color of document type selection buttons.
        public let borderColor: UIColor?
        
        /// The color of text in document type selection buttons.
        public let textColor: UIColor?
        
        /// The background color of the document icon in selection buttons.
        public let iconBackgroundColor: UIColor?
        
        /// The tint color applied to the document icon in selection buttons.
        public let iconTintColor: UIColor?
        
        /// The background color when a document type button is selected.
        public let selectedBackgroundColor: UIColor?
        
        /// The border color when a document type button is selected.
        public let selectedBorderColor: UIColor?
        
        /// The text color when a document type button is selected.
        public let selectedTextColor: UIColor?
    }
    
    public struct AlertDialogColors {
        /// The background color of the alert dialog
        /// Defaults to `surfaceColor` unless explicitly specified.
        public let backgroundColor: UIColor?
        
        /// The color of the title on the alert dialog
        /// Defaults to `onSurfaceColor` unless explicitly specified.
        public let titleColor: UIColor?
        
        /// The color of the message on the alert dialog
        /// Defaults to `onSurfaceColor` unless explicitly specified.
        public let messageColor: UIColor?
        
        /// Colors for the cancel button in the alert dialog
        public let cancelButton: CancelButton
        
        /// Colors for the action button in the alert dialog
        public let actionButton: ActionButton
        
        public struct CancelButton {
            /// The background color of the cancel button.
            /// Defaults to `OutlinedButtonColors.backgroundColor` unless explicitly specified.
            public let backgroundColor: UIColor?
            
            /// The border color of the cancel button.
            /// Defaults to `OutlinedButtonColors.borderColor` unless explicitly specified.
            public let borderColor: UIColor?
            
            /// The text color in the cancel button.
            /// Defaults to `OutlinedButtonColors.textColor` unless explicitly specified.
            public let textColor: UIColor?
        }
        
        public struct ActionButton {
            /// The background color of the action button.
            /// Defaults to `ButtonColors.backgroundColor` unless explicitly specified.
            public let backgroundColor: UIColor?
            
            /// The text color in the action button.
            /// Defaults to `ButtonColors.textColor` unless explicitly specified.
            public let textColor: UIColor?
        }
    }
}
```
Note that each property has its default value, so you can change only those you need.

## Notes

* SDK uses Camera and Photos Library to make photo verification possible, so next entries shold be added to the `Info.plist` of your application:

```
"NSCameraUsageDescription" = "Camera permission is required to create verifications";
"NSPhotoLibraryUsageDescription" = "Library permission is required to create verifications";

```
* SDK uses Microphone to record a video during video verifications, so following entry should be added to the `Info.plist` of your application:
```
"NSMicrophoneUsageDescription" = "Microphone permission is required to create verifications";
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
* Serbian (Cyrillic)
* Serbian (Latin)
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
* Finnish
* Japanese
* Korean
* Norwegian
* Hungarian
* Nepali
* Sinhala
* Tamil
* Arabic
* Kyrgyz

## Links

API documentation:
https://docs.kycaid.com
