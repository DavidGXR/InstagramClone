//
//  StoryCollectionViewCell.swift
//  InstagramClone
//
//  Created by David Im on 10/26/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    var storyBorder = UIView()
    
    override func awakeFromNib() {
        
        addSubview(storyBorder)
        storyBorder.addSubview(storyImage)
        
        storyImage.layer.cornerRadius = storyImage.frame.height/2
        storyImage.translatesAutoresizingMaskIntoConstraints = false
        storyImage.centerXAnchor.constraint(equalTo: storyBorder.centerXAnchor).isActive = true
        storyImage.centerYAnchor.constraint(equalTo: storyBorder.centerYAnchor).isActive = true
        
        storyBorder.translatesAutoresizingMaskIntoConstraints = false
        storyBorder.layer.cornerRadius = 85/2
        storyBorder.layer.borderWidth = 1.5
        storyBorder.heightAnchor.constraint(equalToConstant: 85).isActive = true
        storyBorder.widthAnchor.constraint(equalToConstant: 85).isActive  = true
        storyBorder.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        storyBorder.bottomAnchor.constraint(equalTo: username.topAnchor, constant: -2).isActive = true
    }
}
