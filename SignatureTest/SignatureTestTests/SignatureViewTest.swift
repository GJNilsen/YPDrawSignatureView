// YPDrawSignatureView is open source
// Version 1.1.1
//
// Copyright (c) 2014 - 2017 The YPDrawSignatureView Project Contributors
// Available under the MIT license
//
// https://github.com/GJNilsen/YPDrawSignatureView/blob/master/LICENSE   License Information
// https://github.com/GJNilsen/YPDrawSignatureView/blob/master/README.md Project Contributors

import XCTest
@testable import SignatureTest

class SignatureViewTest: XCTestCase {
    
    var signatureView: YPDrawSignatureView!
    
    override func setUp() {
        super.setUp()
        
        signatureView = YPDrawSignatureView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    func testFrame() {
        let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        XCTAssertEqual(signatureView.frame, frame)
    }
    
    func testClearSignature() {
        signatureView.clear()
        signatureView.strokeColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        signatureView.injectBezierPath(doodle())
        signatureView.draw(signatureView.frame)
        signatureView.clear()
        XCTAssertEqual(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), getPixelColor(view2Image(signatureView), at: CGPoint(x: 4, y: 4)))
    }
    
    func testDrawSignature() {
        signatureView.clear()
        signatureView.strokeColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        signatureView.injectBezierPath(doodle())
        signatureView.draw(signatureView.frame)
        XCTAssertNotEqual(signatureView.backgroundColor, getPixelColor(view2Image(signatureView), at: CGPoint(x: 4, y: 4)))
    }
    
    func testGetSignature() {
        signatureView.clear()
        signatureView.strokeColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        signatureView.injectBezierPath(doodle())
        signatureView.draw(signatureView.frame)
        
        let signature = signatureView.getSignature()
        XCTAssertNotEqual(signatureView.backgroundColor, getPixelColor(signature!, at: CGPoint(x: 4, y: 4)))
    }
    
    
}

// Helper Methods
extension SignatureViewTest {
    
    // Sample signature
    func doodle() -> UIBezierPath {
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 4, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 4.1, y: 4.1), controlPoint1: CGPoint(x: 7.57, y: 3.33), controlPoint2: CGPoint(x: 1.12, y: 3.43))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 4.1), controlPoint1: CGPoint(x: 7.08, y: 4.77), controlPoint2: CGPoint(x: 11.14, y: 0.05))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 5), controlPoint1: CGPoint(x: -3.14, y: 8.15), controlPoint2: CGPoint(x: 4, y: 5))
        bezierPath.addCurve(to: CGPoint(x: 4.1, y: 4), controlPoint1: CGPoint(x: 4, y: 5), controlPoint2: CGPoint(x: 1.72, y: 3.33))
        bezierPath.addCurve(to: CGPoint(x: 4.2, y: 4.2), controlPoint1: CGPoint(x: 6.48, y: 4.67), controlPoint2: CGPoint(x: -3.54, y: 7.57))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 4.2), controlPoint1: CGPoint(x: 11.94, y: 0.83), controlPoint2: CGPoint(x: 4, y: 11.62))
        bezierPath.addCurve(to: CGPoint(x: 4.2, y: 4), controlPoint1: CGPoint(x: 4, y: -3.22), controlPoint2: CGPoint(x: 7.18, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 4.2, y: 4.2), controlPoint1: CGPoint(x: 1.22, y: 4), controlPoint2: CGPoint(x: 4.2, y: 4.2))
        return bezierPath
    }
    
    // Creates an UIImage of a provided view
    func view2Image(_ view: UIView) -> UIImage {
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // Gets the color at a specific location in a provided view
    func getPixelColor(_ image: UIImage, at pos: CGPoint) -> UIColor {
        
        let pixelData = image.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(image.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}


