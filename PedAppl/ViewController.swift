//
//  ViewController.swift
//  PedAppl
//
//  Created by lokesh madugam on 25/09/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let auth = Auth.auth()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        if let user = auth.currentUser {
            print(user.displayName)
            
            let myVC = storyboard.instantiateViewController(withIdentifier: "DashBoardViewController") as? DashBoardViewController
            if let  _ = myVC {
                print("vc")
                myVC?.modalPresentationStyle = .fullScreen
                self.present(myVC!, animated: true) {
                    print("presenting")
                }
            } else {
                print("no vc")
            }
        } else {
            
            let myVC = storyboard.instantiateViewController(withIdentifier: "SigninViewController") as? SigninViewController
            if let  _ = myVC {
                print("vc")
                myVC?.modalPresentationStyle = .fullScreen
                self.present(myVC!, animated: true) {
                    print("presenting")
                }
            } else {
                print("no vc")
            }
//            self.show(myVC!, sender: self)
        }
    }


}

