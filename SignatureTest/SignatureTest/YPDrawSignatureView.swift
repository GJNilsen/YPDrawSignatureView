// YPDrawSignatureView is open source
// Version 1.2.1
//
// Copyright (c) 2014 - 2019 The YPDrawSignatureView Project Contributors
// Available under the MIT license
//
// https://github.com/GJNilsen/YPDrawSignatureView/blob/master/LICENSE   License Information
// https://github.com/GJNilsen/YPDrawSignatureView/blob/master/README.md Project Contributors

import UIKit
import CoreGraphics

// MARK: Class properties and initialization
/// # Class: YPDrawSignatureView
/// Accepts touches and draws an image to an UIView
/// ## Description
/// This is an UIView based class for capturing a signature drawn by a finger in iOS.
/// ## Usage
/// Add the YPSignatureDelegate to the view to exploit the optional delegate methods
/// - startedDrawing(_ view: YPDrawSignatureView)
/// - finishedDrawing(_ view: YPDrawSignatureView)
/// - Add an @IBOutlet, and set its delegate to self
/// - Clear the signature field by calling clear() to it
/// - Retrieve the signature from the field by either calling
/// - getSignature() or
/// - getCroppedSignature()
@IBDesignable
final public class YPDrawSignatureView: UIView {
    
    public weak var delegate: YPSignatureDelegate?
    
    // MARK: - Public properties
    @IBInspectable public var strokeWidth: CGFloat = 2.0 {
        didSet {
            path.lineWidth = strokeWidth
        }
    }
    
    @IBInspectable public var strokeColor: UIColor = .black {
        didSet {
            if !path.isEmpty {
                strokeColor.setStroke()
            }
        }
    }
    
    @objc
    @available(*, deprecated, renamed: "backgroundColor")
    @IBInspectable public var signatureBackgroundColor: UIColor = .white {
        didSet {
            backgroundColor = signatureBackgroundColor
        }
    }
    
    // Computed Property returns true if the view actually contains a signature
    public var doesContainSignature: Bool {
        get {
            if path.isEmpty {
                return false
            } else {
                return true
            }
        }
    }
    
    // MARK: - Private properties
    fileprivate var path = UIBezierPath()
    fileprivate var points = [CGPoint](repeating: CGPoint(), count: 5)
    fileprivate var controlPoint = 0
    
    // MARK: - Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        path.lineWidth = strokeWidth
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        path.lineWidth = strokeWidth
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
    }
    
    // MARK: - Draw
    override public func draw(_ rect: CGRect) {
        self.strokeColor.setStroke()
        self.path.stroke()
    }
    
    // MARK: - Touch handling functions
    override public func touchesBegan(_ touches: Set <UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchPoint = firstTouch.location(in: self)
            controlPoint = 0
            points[0] = touchPoint
        }
        
        if let delegate = delegate {
            delegate.didStart(self)
        }
    }
    
    override public func touchesMoved(_ touches: Set <UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let touchPoint = firstTouch.location(in: self)
            controlPoint += 1
            points[controlPoint] = touchPoint
            if (controlPoint == 4) {
                points[3] = CGPoint(x: (points[2].x + points[4].x)/2.0, y: (points[2].y + points[4].y)/2.0)
                path.move(to: points[0])
                path.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])
                
                setNeedsDisplay()
                points[0] = points[3]
                points[1] = points[4]
                controlPoint = 1
            }
            
            setNeedsDisplay()
        }
    }
    
    override public func touchesEnded(_ touches: Set <UITouch>, with event: UIEvent?) {
        if controlPoint < 4 {
            let touchPoint = points[0]
            path.move(to: CGPoint(x: touchPoint.x,y: touchPoint.y))
            path.addLine(to: CGPoint(x: touchPoint.x,y: touchPoint.y))
            setNeedsDisplay()
        } else {
            controlPoint = 0
        }
        
        if let delegate = delegate {
            delegate.didFinish(self)
        }
    }
    
    // MARK: - Methods for interacting with Signature View
    
    // Clear the Signature View
    public func clear() {
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    // Save the Signature as an UIImage
    public func getSignature(scale:CGFloat = 1) -> UIImage? {
        if !doesContainSignature { return nil }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, scale)
        self.strokeColor.setStroke()
        self.path.stroke()
        let signature = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signature
    }
    
    // Save the Signature (cropped of outside white space) as a UIImage
    public func getCroppedSignature(scale:CGFloat = 1) -> UIImage? {
        guard let fullRender = getSignature(scale:scale) else { return nil }
        let bounds = self.scale(path.bounds.insetBy(dx: -strokeWidth/2, dy: -strokeWidth/2), byFactor: scale)
        guard let imageRef = fullRender.cgImage?.cropping(to: bounds) else { return nil }
        return UIImage(cgImage: imageRef)
    }
    
    
    fileprivate func scale(_ rect: CGRect, byFactor factor: CGFloat) -> CGRect
    {
        var scaledRect = rect
        scaledRect.origin.x *= factor
        scaledRect.origin.y *= factor
        scaledRect.size.width *= factor
        scaledRect.size.height *= factor
        return scaledRect
    }
    
    // Saves the Signature as a Vector PDF Data blob
    public func getPDFSignature() -> Data? {
        
        guard let mutableData = CFDataCreateMutable(nil, 0) else { return nil }
        
        guard let dataConsumer = CGDataConsumer(data: mutableData) else { return nil }
        
        var rect = CGRect(origin: .zero, size: frame.size)
        
        guard let pdfContext = CGContext(consumer: dataConsumer, mediaBox: &rect, nil) else { return nil }

        pdfContext.beginPDFPage(nil)
        pdfContext.translateBy(x: 0, y: frame.height)
        pdfContext.scaleBy(x: 1, y: -1)
        pdfContext.addPath(path.cgPath)
        pdfContext.setStrokeColor(strokeColor.cgColor)
        pdfContext.strokePath()
        pdfContext.saveGState()
        pdfContext.endPDFPage()
        pdfContext.closePDF()
        
        return mutableData as Data
    }
    
    
    // MARK: - Injection method for Unit Tests only
    /// This method is used to inject a bezier path for testing
    /// purposes only. This method is not included in the main
    /// YPDrawSignatureView.swift source file by intention.
    func injectBezierPath(_ path: UIBezierPath) {
        self.path = path
    }
}

// MARK: - Protocol definition for YPDrawSignatureViewDelegate
/// ## YPDrawSignatureViewDelegate Protocol
/// YPDrawSignatureViewDelegate:
/// - optional didStart()
/// - optional didFinish()
@objc
public protocol YPSignatureDelegate: class {
    func didStart(_ view : YPDrawSignatureView)
    func didFinish(_ view : YPDrawSignatureView)
}

extension YPSignatureDelegate {
    func didStart(_ view : YPDrawSignatureView) {}
    func didFinish(_ view : YPDrawSignatureView) {}
}
