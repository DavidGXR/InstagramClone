//
//  AccountViewController.swift
//  InstagramClone
//
//  Created by David Im on 11/19/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameBarButton: UIButton!
    
    private var userInfo = [User(name: "Im David", username: "imdavid10", image: UIImage(named: C.userProfilePicture)!, bio: "iOS Developer", website: "www.daveios.com", numberOfPost: 6, numberOfFollower: 687, numberOfFollowing: 582)]
    private let textFieldUtil = TextFieldUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameBarButton.setTitle(userInfo[0].username, for: .normal)
    }
} // End of class

//MARK: - TableView
extension AccountViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let profileCell = tableView.dequeueReusableCell(withIdentifier: C.userProfileCell) as! AccountTableViewCell
           
            profileCell.name.text   = userInfo[0].name
            profileCell.bio.text    = userInfo[0].bio
            
            let numberOfPost        = textFieldUtil.boldText(boldText: userInfo[0].numberOfPost, regularText: "Posts", size: 15.0)
            let numberOfFollower    = textFieldUtil.boldText(boldText: userInfo[0].numberOfFollower, regularText: "Followers", size: 15.0)
            let numberOfFollowing   = textFieldUtil.boldText(boldText: userInfo[0].numberOfFollowing, regularText: "Following", size: 15.0)
            
            profileCell.numberOfPost.setAttributedTitle(numberOfPost, for: .normal)
            profileCell.numberOfFollower.setAttributedTitle(numberOfFollower, for: .normal)
            profileCell.numberOfFollowing.setAttributedTitle(numberOfFollowing, for: .normal)
            
            return profileCell
        }else{
            let photoCell = tableView.dequeueReusableCell(withIdentifier: C.userPhotoCell) as! PhotoTableViewCell
            photoCell.photoCellDelegate = self
            photoCell.photoCollectionView.delegate      = self
            photoCell.photoCollectionView.dataSource    = self
            
            return photoCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            let imageSize  = self.view.frame.width/3
            return (imageSize * 6) + 32 // imgSize * (number of items in collectionView / 3) + height of segmentControl
        }else{
            return UITableView.automaticDimension
        }
    }
}

//MARK: - PhotoCollectionView
extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,PhotoTableViewCellDelegateMethods{
    
    func segmentControl(index: Int, collectionView: UICollectionView) {
        if index == 1{
            userInfo[0].image = UIImage(named: C.instagramLogo)!
            collectionView.reloadData()
        }else{
            userInfo[0].image = UIImage(named: C.userProfilePicture)!
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: C.userPhotoCollectionView, for: indexPath) as! PhotoCollectionViewCell
        photoCell.image.image = userInfo[0].image
        
        return photoCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth    = self.view.frame.width/3
        let cellHeight   = cellWidth
        return CGSize(width: (cellWidth - 0.3), height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

