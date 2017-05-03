# YPDrawSignatureView

Simple class for capturing signatures.

## Swift 3

The class supports Swift 3.
This branch is not backwards compatible, please download the previous release if you can not support Swift 3. Legacy versions will not be updated anymore.

- Swift 3.0 will be supported
- Swift 2.3 will not be supported

## Usage

Add a new `UIView` where you want the signature capture field. Set its class to `YPDrawSignatureView`, and connect it to an `@IBOutlet` property in your `UIViewController`. For saving and clearing the signature, add two buttons to your view controller. Hook each button up to an `@IBAction` function.

![ScreenShot](ibss.png?raw=true "Interface Builder Attributes Inspector panel")

With the view selected, choose the IB Attributes Inspector panel to set custom values, or set them in code where you initialize the signature view.

#### Methods

* `clear()`

This clears the view

* `getSignature()`

This returns the signature with the bounds of the view

* `getCroppedSignature()`

This returns the signature with the bounds of the signature

#### Properties

* `doesContainSignature: Bool`

This is a computed read-only property returning `true` if the view actually contains a signature

* `strokeWidth: CGFloat`

Sets the width of the signature stroke

* `strokeColor: UIColor`

Sets the UIColor of the signature stroke

* `signatureBackgroundColor: UIColor`

Sets the background UIColor of the view

#### Optional Protocol Methods

* `startedDrawing()`

Notifies the delegate when someone starts a stroke in the view

* `finishedDrawing()`

Notifies the delegate when someone finishes a stroke in the view

#### Example Code

The following sample code checks if there is a signature in the view before getting it.

```
class MyViewController: UIViewController, YPSignatureDelegate {

    @IBOutlet weak var drawSignatureView: YPDrawSignatureView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        drawSignatureView.delegate = self
    }

    @IBAction func save(sender: AnyObject) {
        // Checking if the view actually contains a signature
        if drawSignatureView.doesContainSignature {
            let img = drawSignatureView.getCroppedSignature()
            // Do something with img
        } else {
            // Alert the user or do something else
        }
    }

    @IBAction func clear(sender: AnyObject) {
        drawSignatureView.clear()
    }

    // MARK: - Optional delegate methods
    func startedDrawing() {
        // Do something when start drawing
    }

    func finishedDrawing() {
        // Do something else when finished drawing
    }
}
```

## Example Project

Check out the example project for more information on how to save signatures and how to clear the signature view.

## Installation

Add YPDrawSignature.swift to your project

## Support and Issues

GitHub Issues are for filing bug reports and feature requests only. Use [StackOverflow](http://stackoverflow.com/search?q=YPDrawSignatureView) for support related questions and help.

## Original Author

[Geert-Jan Nilsen](mailto:gj.nilsen@appfact.com) [Yuppielabel](http://yuppielabel.com)

## Contributors

* [TyrantFox](https://github.com/TyrantFox).
* [gingofthesouth](https://github.com/gingofthesouth).
* [AndreasLey](https://github.com/andreasley).
* [Andrew Carvajal](https://github.com/andrewcar).

## License

YPDrawSignatureView is available under the MIT license. See the [LICENSE](LICENSE) file for more info. Feel free to fork and modify.

## Update history

### v1.0.2 - 5/3/17

* Cleaning up method naming
* Delegate methods are now optional
* Sample project updated to latest settings

#### v1.0.1 - 5/2/17

* Minor bugfix

#### v1.0 - 9/12/16

* More Swifty API
* Supports Swift 3
