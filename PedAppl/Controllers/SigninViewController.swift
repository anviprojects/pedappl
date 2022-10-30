//
//  SigninViewController.swift
//  UI
//
//  Created by lokesh madugam on 25/09/22.
//

import UIKit
import FacebookLogin
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class SigninViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotPwdLabel: UILabel!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var emailTxtFld: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let signupTap = UITapGestureRecognizer(target: self, action: #selector(showSignupScreen))
        signupLabel.addGestureRecognizer(signupTap)
    }
    
    @objc func showSignupScreen() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "SingUPViewController") as? SingUPViewController
        if let  _ = myVC {
            print("vc")
            myVC?.modalPresentationStyle = .fullScreen
            self.present(myVC!, animated: true) {
                print("presenting")
            }
        } else {
            print("no vc")
        }
    }

    @IBAction func ontappedFbBtn(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                
                Profile.loadCurrentProfile { profile, error in
                    if let firstName = profile?.firstName {
                        print("Hello, \(firstName)")
                    }
                }
                
                let credential = FacebookAuthProvider
                  .credential(withAccessToken: AccessToken.current!.tokenString)
                self.parseCredential(credential: credential)
                
            }
        }
            
    }
    
    @IBAction func onTappedGoogleBtn(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

            self.parseCredential(credential: credential)
        }
    }
    @IBAction func onTappedCheckBtn(_ sender: Any) {
    }
    
    @IBAction func onTappedLoginBtn(_ sender: Any) {
    }
}


extension SigninViewController {
    
    func parseCredential(credential : AuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                let authError = error as NSError
                print(authError.localizedDescription)
                return
              }
              
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
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
              return
            }
        
    }
    
    
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
}
