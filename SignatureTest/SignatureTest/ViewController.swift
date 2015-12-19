//
//  ViewController.swift
//  SignatureTest
//
//  Created by Geert-Jan Korsbø Nilsen on 19/12/15.
//  Copyright © 2015 Yuppielabel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  // Connect this Outlet to the Signature View
  @IBOutlet weak var drawSignatureView: YPDrawSignatureView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func clearSignature(sender: UIButton) {
    // This is how the signature gets cleared
    self.drawSignatureView.clearSignature()
  }
  
  @IBAction func saveSignature(sender: UIButton) {
    // Getting the Signature Image from self.drawSignatureView using the method getSignature().
    let signatureImage = self.drawSignatureView.getSignature()
    
    // Saving signatureImage from the line above to the Photo Roll.
    // The first time you do this, the app asks for access to your pictures.
    UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
    
    // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
    self.drawSignatureView.clearSignature()
  }
  

}

