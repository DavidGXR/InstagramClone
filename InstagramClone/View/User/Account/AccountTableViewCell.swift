//
//  AccountTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 11/20/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var numberOfPost: UIButton!
    @IBOutlet weak var numberOfFollower: UIButton!
    @IBOutlet weak var numberOfFollowing: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var editProfileButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePicture.layer.cornerRadius           = profilePicture.frame.height/2
        
        bio.contentInset                            = UIEdgeInsets(top: -7.0,left: -5.4,bottom: 0.0,right: 0.0);
        
        editProfileButton.layer.cornerRadius        = editProfileButton.frame.height/8
        editProfileButton.layer.borderWidth         = 0.5
        editProfileButton.layer.borderColor         = UIColor.gray.cgColor
        
        numberOfPost.titleLabel?.textAlignment      = .center
        numberOfFollowing.titleLabel?.textAlignment = .center
        numberOfFollower.titleLabel?.textAlignment  = .center
    }
}
