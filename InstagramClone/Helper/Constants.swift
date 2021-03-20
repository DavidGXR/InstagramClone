//
//  Constants.swift
//  InstagramClone
//
//  Created by David Im on 6/11/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import UIKit

struct C {
   
    //MARK: - Font
    static let instagramFont            = "Billabong"
    
    //MARK: - Firebase
    static let documentID               = "userinfo"
    static let username                 = "username"
    static let password                 = "password"
    
    //MARK: - ViewController
    static let logInVC                  = "logInVC"
    static let signUpVC                 = "signUpVC"
    static let homeVC                   = "homeVC"
    static let cameraVC                 = "cameraVC"
    static let messageVC                = "messageVC"
    static let commentVC                = "commentVC"
    
    //MARK: - TableViewCell and CollectionViewCell
    static let storyCollectionView      = "storyCollectionView"
    static let storyTableViewCell       = "storyCell"
    static let homeTableViewCell        = "homeCell"
    static let userCellInCommentSection = "userCell"
    static let followerCellInCommentSection = "followerCell"
    static let likeCell                 = "likeCell"
    static let userProfileCell          = "profileCell"
    static let userPhotoCell            = "photoCell"
    static let userPhotoCollectionView  = "photoCollection"
    static let searchTableViewCell      = "searchCell"
    static let trendingTableViewCell    = "trendingCell"
    static let trendingCollectionView   = "trendingCollection"
    static let trendingMenuCollectionView = "trendingMenuCollection"
    
    //MARK: - Nib
    static let trendingMenuHeader       = "TrendingMenuHeader"
    static let trendingMenuCollectionViewFile = "TrendingMenuCollectionViewCell"

    //MARK: - Messages
    static let errorEmail               = "The email address is badly formatted."
    static let errorPassword            = "The password is invalid or the user does not have a password."
    static let emailExist               = "The email address is already in use by another account."
    static let usernameExist            = "Username already exists"
    static let success                  = "Success"

    //MARK: - Images
    static let tickIcon                 = "tick"
    static let crossIcon                = "cross"
    static let userProfilePicture       = "userProfilePicture"
    static let followerProfilePicture   = "followerProfilePicture"
    static let instagramLogo            = "instagramLogo"
    static let heartButtonUnselected    = "like_unselected"
    static let heartButtonSelected      = "like_selected"
    static let cristinao                = "cristiano"
    static let vini                     = "vini"
    static let nikeLogo                 = "nikelogo"
    static let nikeShoes                = "nike"
}
