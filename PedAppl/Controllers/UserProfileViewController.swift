//
//  UserProfileViewController.swift
//  UI
//
//  Created by lokesh madugam on 25/09/22.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailAdd1TxtFld: UITextField!
    @IBOutlet weak var emailAdd2TxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    @IBAction func onTappedEditBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var onTappedProfileBtn: UITabBarItem!
    @IBOutlet weak var onTappedRefreshbtn: UITabBarItem!
    @IBOutlet weak var onTappedHomeBtn: UITabBarItem!
    
    @IBAction func onTapppedSignOutBtn(_ sender: Any) {
    }
}
