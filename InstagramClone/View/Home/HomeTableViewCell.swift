//
//  HomeTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 10/29/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

protocol HomeVCButtonTap{
    func editButtonTapped()
    func heartButtonTapped(postIndex: Int)
    func commentButtonTapped(postIndex: Int)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imageOfPost: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var totalLike: UIButton!
    @IBOutlet weak var secondUsername: UIButton!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var time: UILabel!
    
    var homeCellDelegate:HomeVCButtonTap?
    var postIndex: Int?
    var heartImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 105, height: 80))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnImage))
        tap.numberOfTapsRequired = 2
        imageOfPost.isUserInteractionEnabled = true
        imageOfPost.addGestureRecognizer(tap)
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func usernameButton(_ sender: UIButton) {
    }
    
    @IBAction func locationButton(_ sender: UIButton) {
    }
    
    
    @IBAction func editButton(_ sender: UIButton) {
        homeCellDelegate?.editButtonTapped()
    }
    
    @IBAction func heartButton(_ sender: UIButton) {
        homeCellDelegate?.heartButtonTapped(postIndex: postIndex ?? 0)
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        
    }
    
    @IBAction func secondUsernameButton(_ sender: UIButton) {
    }
    
    
    @IBAction func commentButton(_ sender: UIButton) {
        homeCellDelegate?.commentButtonTapped(postIndex: postIndex ?? 0)
    }
    
    @objc private func tapOnImage() {
        homeCellDelegate?.heartButtonTapped(postIndex: postIndex ?? 0)
        heartImage()
    }
    
    private func heartImage(){
        heartImageView.image            = UIImage(systemName: "heart.fill")
        heartImageView.tintColor        = UIColor.white
        heartImageView.center           = CGPoint(x: imageOfPost.frame.width/2, y: imageOfPost.frame.height/2)
        imageOfPost.addSubview(heartImageView)
    }
    
} /// End of class
