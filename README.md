# YPDrawSignatureView

Simple class for capturing signatures.

Inspired by [Capture a Signature on iOS](https://www.altamiracorp.com/blog/employee-posts/capture-a-signature-on-ios) by Jason Harwig, and [Macheads101](https://www.youtube.com/user/macheads101), he has a great [tutorial](https://www.youtube.com/watch?v=8KV1o9hPF5E&list=UU7fIuG6L5EPc9Ijq2_BCmIg) on YouTube.

## Swift 2.2

The class supports Swift 2.2

## Usage

Add a new `UIView` where you want the signature capture field. Set its class to `YPDrawSignatureView`, and connect it to an `@IBOutlet` property in your `UIViewController`. For saving and clearing the signature, add two buttons to your view controller. Hook each button up to an `@IBAction` function.

![ScreenShot](ibss.png?raw=true "Interface Builder Attributes Inspector panel")

With the view selected, choose the IB Attributes Inspector panel to set custom values, or set them in code where you initialize the signature view.

## Example Project

Check out the example project for more information on how to save signatures and how to clear the signature view.

## Installation

Add YPDrawSignature.swift to your project

## Support and Issues

GitHub Issues are for filing bug reports and feature requests only. Use [StackOverflow](http://stackoverflow.com/search?q=YPDrawSignatureView) for support related questions and help.

## Original Author

[Geert-Jan Nilsen](mailto:gj.nilsen@yuppielabel.com) [Yuppielabel](http://yuppielabel.com)

## Contributors

* [TyrantFox](https://github.com/TyrantFox).
* [gingofthesouth](https://github.com/gingofthesouth).

## License

YPDrawSignatureView is available under the MIT license. See the [LICENSE](LICENSE) file for more info. Feel free to fork and modify.
