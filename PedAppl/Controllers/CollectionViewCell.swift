//
//  CollectionViewCell.swift
//  UI
//
//  Created by lokesh madugam on 25/09/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        
    }

}
