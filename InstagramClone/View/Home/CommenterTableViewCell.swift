//
//  CommenterTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 11/11/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

protocol CommentVCButtonTap{
    func heartButtonTap(index:Int)
}

class CommenterTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    
    var commentIndex:Int?
    var commentCellDelegate:CommentVCButtonTap?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    @IBAction func heartButton(_ sender: UIButton) {
        commentCellDelegate?.heartButtonTap(index: commentIndex ?? 1)
    }
}

