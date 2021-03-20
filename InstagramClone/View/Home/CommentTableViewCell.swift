//
//  CommentTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 11/9/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
}


