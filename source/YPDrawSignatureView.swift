// YPDrawSignatureView is open source
//
// Copyright (c) 2014 - 2016 Yuppielabel and the project contributors
// Available under the MIT license
//
// See https://github.com/yuppielabel/YPDrawSignatureView/blob/master/LICENSE for license information
// See https://github.com/yuppielabel/YPDrawSignatureView/blob/master/README.md for the list project contributors

import UIKit

@IBDesignable
public class YPDrawSignatureView: UIView {
    
    // MARK: - Public properties
    @IBInspectable public var strokeWidth: CGFloat = 2.0 {
        didSet {
            self.path.lineWidth = strokeWidth
        }
    }
    
    @IBInspectable public var strokeColor: UIColor = UIColor.blackColor() {
        didSet {
            self.strokeColor.setStroke()
        }
    }
    
    @IBInspectable public var signatureBackgroundColor: UIColor = UIColor.whiteColor() {
        didSet {
            self.backgroundColor = signatureBackgroundColor
        }
    }
    
    // Redundant Stroke Width property for backwards compatibility
    public var lineWidth: CGFloat {
        set {
            self.strokeWidth = lineWidth
        }
        get {
            return self.strokeWidth
        }
    }
    
    // MARK: - Private properties
    private var path = UIBezierPath()
    private var pts = [CGPoint](count: 5, repeatedValue: CGPoint())
    private var ctr = 0
    
    // MARK: - Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.strokeWidth
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.strokeWidth
    }
    
    // MARK: - Draw
    override public func drawRect(rect: CGRect) {
        self.strokeColor.setStroke()
        self.path.stroke()
    }
    
    // MARK: - Touch handling functions
    override public func touchesBegan(touches: Set <UITouch>, withEvent event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchPoint = firstTouch.locationInView(self)
            self.ctr = 0
            self.pts[0] = touchPoint
        }
    }
    
    override public func touchesMoved(touches: Set <UITouch>, withEvent event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchPoint = firstTouch.locationInView(self)
            self.ctr += 1
            self.pts[self.ctr] = touchPoint
            if (self.ctr == 4) {
                self.pts[3] = CGPointMake((self.pts[2].x + self.pts[4].x)/2.0, (self.pts[2].y + self.pts[4].y)/2.0)
                self.path.moveToPoint(self.pts[0])
                self.path.addCurveToPoint(self.pts[3], controlPoint1:self.pts[1], controlPoint2:self.pts[2])
                
                self.setNeedsDisplay()
                self.pts[0] = self.pts[3]
                self.pts[1] = self.pts[4]
                self.ctr = 1
            }
            
            self.setNeedsDisplay()
        }
    }
    
    override public func touchesEnded(touches: Set <UITouch>, withEvent event: UIEvent?) {
        if self.ctr == 0 {
            let touchPoint = self.pts[0]
            self.path.moveToPoint(CGPointMake(touchPoint.x-1.0,touchPoint.y))
            self.path.addLineToPoint(CGPointMake(touchPoint.x+1.0,touchPoint.y))
            self.setNeedsDisplay()
        } else {
            self.ctr = 0
        }
    }
    
    // MARK: - Methods for interacting with Signature View
    
    // Clear the Signature View
    public func clearSignature() {
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    // Save the Signature as an UIImage
    public func getSignature() -> UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height))
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let signature = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return signature
    }
    
    // Save the Signature (cropped of outside white space) as a UIImage
    public func getSignatureCropped() -> UIImage {
        // Get the UIView full render
        let fullRender = getSignature()
        
        // Get a CGImage reference of the signature for just the bounds of the bezier path
        let imageRef = CGImageCreateWithImageInRect(fullRender.CGImage, path.bounds)!
        
        // Create a UIImage with the cropped CGImage
        let signature = UIImage(CGImage: imageRef)
        
        return signature
    }
}
