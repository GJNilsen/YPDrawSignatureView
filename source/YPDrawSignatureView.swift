//
//  YPDrawSignatureView.swift
//  Draw a signature into an UIView
//
//  Created by Geert-Jan Nilsen on 06/11/14.
//  Copyright (c) 2014 Yuppielabel.com All rights reserved.
//

import UIKit

class YPDrawSignatureView: UIView {
    
    // MARK: - Properties
    var path = UIBezierPath()
    var pts: [CGPoint] = [CGPoint(),CGPoint(),CGPoint(),CGPoint(),CGPoint()]
    var ctr: Int = 0
    
    // MARK: - Init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Capturing Touches
        // DrawTouch
        var pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target:self, action:"pan:")
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        pan.cancelsTouchesInView = true
        self.addGestureRecognizer(pan)
        
        // Dotting-The-I's-Touches
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:"tap:")
        pan.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
        
        
        self.backgroundColor = UIColor.whiteColor()
        self.path.lineWidth = 2.0
    }
    
    // MARK: - Draw
    override func drawRect(rect: CGRect) {
        self.path.stroke()
    }
    
    // MARK: - Gesture Recognizers
    
    // MARK: Pan - Draws the Signature Curves
    func pan(touch: UIPanGestureRecognizer){
        let touchPoint: CGPoint = touch.locationInView(self)
        
        if (touch.state == UIGestureRecognizerState.Began) {
            
            self.ctr = 0
            self.pts[0] = touchPoint
            
        } else if (touch.state == UIGestureRecognizerState.Changed) {
            
            self.ctr++
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
            
        } else if (touch.state == UIGestureRecognizerState.Ended || touch.state == UIGestureRecognizerState.Cancelled) {
            
            self.path.addLineToPoint(touchPoint)
            self.ctr = 0
            self.setNeedsDisplay()
            
        }
        
    }
    
    // MARK: Tap - Draws the Dots
    func tap(touch: UITapGestureRecognizer){
        var touchPoint: CGPoint = touch.locationInView(self)
        self.path.moveToPoint(CGPointMake(touchPoint.x-1.0,touchPoint.y))
        self.path.addLineToPoint(CGPointMake(touchPoint.x+1.0,touchPoint.y))
        self.setNeedsDisplay()
    }
    
    // MARK: - Helpers
    
    // MARK: Clear the Signature View
    func clearSignature() {
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    // MARK: Save the Signature as an UIImage
    func getSignature() ->UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height))
        self.layer.renderInContext(UIGraphicsGetCurrentContext())
        var signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signature
    }
    
}
