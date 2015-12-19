//
//  ViewController.swift
//  SignatureTest
//
//  Created by Geert-Jan Korsbø Nilsen on 19/12/15.
//  Copyright © 2015 Yuppielabel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    self.drawSignatureView.clearSignature()
  }
  
  @IBAction func saveSignature(sender: UIButton) {
    UIImageWriteToSavedPhotosAlbum(self.drawSignatureView.getSignature(), nil, nil, nil)
    self.drawSignatureView.clearSignature()
  }
  

}

