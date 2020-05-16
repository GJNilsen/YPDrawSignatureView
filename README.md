# YPDrawSignatureView
[![Financial Contributors on Open Collective](https://opencollective.com/YPDrawSignatureView/all/badge.svg?label=financial+contributors)](https://opencollective.com/YPDrawSignatureView) ![Image of Swift Version Badge](https://img.shields.io/badge/Swift-5-lightgrey.svg)
Simple class for capturing signatures.

## Swift 5

The class is compatible with Swift 5


## Legacy Support

The class is not backwards compatible. Please download previous releases if you need support for earlier versions of Swift. Legacy versions will not be updated.


## Usage

Add a new `UIView` where you want the signature capture field. Set its class to `YPDrawSignatureView`, and connect it to an `@IBOutlet` property in your `UIViewController`. For saving and clearing the signature, add two buttons to your view controller. Hook each button up to an `@IBAction` function.

![ScreenShot](ibss.png?raw=true "Interface Builder Attributes Inspector panel")

With the view selected, choose the IB Attributes Inspector panel to set custom values, or set them in code where you initialise the signature view.


## New Feature

On ground of popular demand, added signature export as Vector Path in PDF Data Format.


#### Methods

* `clear()`

Clears signature

* `getSignature()`

Returns signature with bounds of YPDrawSignatureView instance

* `getCroppedSignature()`

Returns signature with bounds of signature

* `getPDFSignature()`
Returns signature as Vector Path PDF Data Format

#### Properties

* `doesContainSignature: Bool`

This is a computed read-only property returning `true` if the view actually contains a signature

* `strokeWidth: CGFloat`

Sets the width of the signature stroke

* `strokeColor: UIColor`

Sets the UIColor of the signature stroke


#### Optional Protocol Methods

* `didStart(_ view: YPDrawSignatureView)`

Notifies the delegate when someone starts a stroke in the view. 

* `didFinish(_ view: YPDrawSignatureView)`

Notifies the delegate when someone finishes a stroke in the view

#### Example Code

The following sample code checks if there is a signature in the view before getting it.

```
class ViewController: UIViewController, YPSignatureDelegate {
    
    // Connect this Outlet to the Signature View
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting this view controller as the signature view delegate, so the didStart() and
        // didFinish() methods below in the delegate section are called.
        signatureView.delegate = self
    }
    
    // Function for clearing the content of signature view
    @IBAction func clearSignature(_ sender: UIButton) {
        // This is how the signature gets cleared
        self.signatureView.clear()
    }
    
    // Function for saving signature
    @IBAction func saveSignature(_ sender: UIButton) {
        // Getting the Signature Image from self.drawSignatureView using the method getSignature().
        if let signatureImage = self.signatureView.getSignature(scale: 10) {
            
            // Saving signatureImage from the line above to the Photo Roll.
            // The first time you do this, the app asks for access to your pictures.
            UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.signatureView.clear()
        }
    }
    
    // MARK: - Delegate Methods
    
    // The delegate functions gives feedback to the instanciating class. All functions are optional,
    // meaning you just implement the one you need.
    
    // didStart(_ view: YPDrawSignatureView) is called right after the first touch is registered in the view.
    // For example, this can be used if the view is embedded in a scroll view, temporary
    // stopping it from scrolling while signing.
    func didStart(_ view: YPDrawSignatureView) {
        print("Started Drawing")
    }
    
    // didFinish(_ view: YPDrawSignatureView) is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish(_ view: YPDrawSignatureView) {
        print("Finished Drawing")
    }
}
```

## Example Project

Check out the example project for more information on how to save signatures and how to clear the signature view.

## Installation

Add YPDrawSignature.swift to your project

## Support and Issues

GitHub Issues are for filing **bug reports** and **feature requests** only. Get support from the community over at [StackOverflow](http://stackoverflow.com/search?q=YPDrawSignatureView), or contact the author directly for paid support.

CocoaPods are **not supported**, the Pod is **not** official, and points to an old release containing bugs that have been fixed years ago. Do **not** use CocoaPods.

## Original Author

[Geert-Jan Zwart](mailto:gj.zwart@appfact.com) [Appfact](http://appfact.no)

## Contributors

* [TyrantFox](https://github.com/TyrantFox).
* [gingofthesouth](https://github.com/gingofthesouth).
* [AndreasLey](https://github.com/andreasley).
* [Andrew Carvajal](https://github.com/andrewcar).
* [Steve Botello](https://github.com/xsteviex).

## Contributors

### Code Contributors

This project exists thanks to all the people who contribute. [[Contribute](CONTRIBUTING.md)].
<a href="https://github.com/GJNilsen/YPDrawSignatureView/graphs/contributors"><img src="https://opencollective.com/YPDrawSignatureView/contributors.svg?width=890&button=false" /></a>

### Financial Contributors

Become a financial contributor and help us sustain our community. [[Contribute](https://opencollective.com/YPDrawSignatureView/contribute)]

#### Individuals

<a href="https://opencollective.com/YPDrawSignatureView"><img src="https://opencollective.com/YPDrawSignatureView/individuals.svg?width=890"></a>

#### Organizations

Support this project with your organization. Your logo will show up here with a link to your website. [[Contribute](https://opencollective.com/YPDrawSignatureView/contribute)]

<a href="https://opencollective.com/YPDrawSignatureView/organization/0/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/0/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/1/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/1/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/2/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/2/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/3/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/3/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/4/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/4/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/5/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/5/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/6/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/6/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/7/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/7/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/8/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/8/avatar.svg"></a>
<a href="https://opencollective.com/YPDrawSignatureView/organization/9/website"><img src="https://opencollective.com/YPDrawSignatureView/organization/9/avatar.svg"></a>

## License

YPDrawSignatureView is available under the MIT license. See the [LICENSE](LICENSE) file for more info. Feel free to fork and modify.

## Update history

### v1.2.1 - 5/6/19

* Fixed annoying complaint. ```CGContextSetStrokeColorWithColor: invalid context 0x0.```
* Updated to Swift 5

#### v1.2 - 7/4/18

* Added support for multiple signature views.

#### v1.1.3 - 3/30/18

* Minor bugfix.

#### v1.1.2 - 6/16/17

* Minor bugfix.

#### v1.1.1 - 5/23/17

* Bugfix

#### v1.1 - 5/3/17

* Added PDF support for exporting signature as high resolution vector graphics
* Deprecated methods and properties are properly marked
* Cleaning up method naming
* Delegate methods are now optional
* Sample project updated to latest settings

#### v1.0.1 - 5/2/17

* Minor bugfix

#### v1.0 - 9/12/16

* More Swifty API
* Supports Swift 3
