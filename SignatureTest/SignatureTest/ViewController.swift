// YPDrawSignatureView is open source
// Version 0.2.1
//
// Copyright (c) 2014 - 2016 Yuppielabel and the project contributors
// Available under the MIT license
//
// See https://github.com/yuppielabel/YPDrawSignatureView/blob/master/LICENSE for license information
// See https://github.com/yuppielabel/YPDrawSignatureView/blob/master/README.md for the list project contributors

import UIKit

class ViewController: UIViewController, YPSignatureDelegate {
    
    // Connect this Outlet to the Signature View
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signatureView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearSignature(_ sender: UIButton) {
        // This is how the signature gets cleared
        self.signatureView.clear()
    }
    
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
    
    // The delegate methods gives feedback to the instanciating class
    func finishedDrawing() {
        print("Finished")
    }
    
    func startedDrawing() {
        print("Started")
    }
    
}
