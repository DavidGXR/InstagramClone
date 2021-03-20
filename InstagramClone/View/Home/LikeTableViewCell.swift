//
//  LikeTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 11/18/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class LikeTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.followButton.layer.cornerRadius = followButton.frame.height/6
        self.followButton.setImage(UIImage(named: "follow"), for: .normal)
    }

    @IBAction func followButtonAction(_ sender: UIButton) {
        if !sender.isSelected == true {
            self.followButton.backgroundColor = .white
            self.followButton.setImage(UIImage(named: "following"), for: .normal)
            sender.isSelected = true
        }else{
            self.followButton.setImage(UIImage(named: "follow"), for: .normal)
            sender.isSelected = false
        }
    }
}
