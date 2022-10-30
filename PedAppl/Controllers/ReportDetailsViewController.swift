//
//  ReportDetailsViewController.swift
//  UI
//
//  Created by lokesh madugam on 25/09/22.
//

import UIKit

class ReportDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var attachedImg: UILabel!
    @IBOutlet weak var forwardImg: UIImageView!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet weak var profileBarBtn: UITabBarItem!
    @IBOutlet weak var refreshBarBtn: UITabBarItem!
    @IBOutlet weak var homebarBtn: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

  
    @IBAction func onTappedForwardBtn(_ sender: Any) {
    }
    
}
