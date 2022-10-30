
//
//  SingUPViewController.swift
//  UI
//
//  Created by lokesh madugam on 23/09/22.
//

import UIKit

class SingUPViewController: UIViewController {

    @IBOutlet weak var nameTxtFld: UITextField!
    
    @IBOutlet weak var councilEmailTxtFld: UITextField!
    
    @IBOutlet weak var emailTxtFld: UITextField!
  
    @IBOutlet weak var passwordTxtFld: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onTappedCancel(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func onTappedSignupBtn(_ sender: Any) {
        
    }
}
