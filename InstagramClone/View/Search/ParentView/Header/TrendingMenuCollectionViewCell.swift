//
//  TrendingMenuCollectionViewCell.swift
//  InstagramClone
//
//  Created by David Im on 12/1/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class TrendingMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var menuButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        menuButton.layer.cornerRadius = menuButton.frame.height / 4.5
        menuButton.layer.borderColor  = UIColor.lightGray.cgColor
        menuButton.layer.borderWidth  = 0.5
       // menuButton.sizeToFit()
    }

}
