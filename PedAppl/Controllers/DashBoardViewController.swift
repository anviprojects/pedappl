//
//  DashBoardViewController.swift
//  UI
//
//  Created by lokesh madugam on 25/09/22.
//

import UIKit
import FirebaseAuth

class DashBoardViewController: UIViewController {
    
    
    @IBOutlet weak var homeView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileBarBtn: UITabBarItem!
    @IBOutlet weak var historyBarBtn: UITabBarItem!
    @IBOutlet weak var homebarBtn: UITabBarItem!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    
    let issues = ["Side Walk Issues", "Street Lights", "Dry Plants at Path Side", "Narrow Pathway", "Reckless Driving", "Zebra Crossing"]
    let images = ["side_walk","street_lights", "dry_plants", "narrow_pathway", "reckless_driving", "zebra_crossing"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tabBar.delegate = self
        setupBarBtns()
        setupProfile()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell")
        
        tabBar.selectedItem = tabBar.items![0]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
    }
    
    func setupBarBtns() {
        
    }
    
    func setupProfile() {
        if let user = Auth.auth().currentUser {
            nameLabel.text = user.displayName
            emailTextField.text = user.email
            if let _ = user.photoURL {
                let url: URL = user.photoURL!
                do {
                    let data = try Data(contentsOf: url)
                    userImageView.image = UIImage(data: data)
                } catch {
                    
                }
            }
        }
    }
    
    @objc func showProfileView() {
        self.homeView.alpha = 0
        self.profileView.alpha = 1
    }

    func showHomeView() {
        self.homeView.alpha = 1
        self.profileView.alpha = 0
    }

    @IBAction func onTapSignOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            
        }
    }
}


extension DashBoardViewController : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == profileBarBtn.title {
            showProfileView()
        } else {
            showHomeView()
        }
    }
}


extension DashBoardViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionViewCell
        cell?.nameLbl.text = issues[indexPath.row]
        cell?.img.image = UIImage(named: images[indexPath.row])
        return cell!
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let padding: CGFloat =  15
            let size = self.view.frame.width

        print("Cell size", size)
            return CGSize(width: size/2 - padding, height: 150)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "NewReportViewController") as? NewReportViewController
        if let  _ = myVC {
            print("vc")
//            myVC?.modalPresentationStyle = .fullScreen
            self.present(myVC!, animated: true) {
                print("presenting")
            }
        } else {
            print("no vc")
        }
    }
    
}
