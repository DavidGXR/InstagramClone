//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by David Im on 10/23/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let storyArray:[Story] = [Story(username: "Your Story", image: UIImage(named: C.userProfilePicture)!, accountOwner: true),
                                      Story(username: "nike", image: UIImage(named: C.nikeLogo)!, accountOwner: false),
                                      Story(username: "cristiano", image: UIImage(named: C.cristinao)!, accountOwner: false),
                                      Story(username: "vinijr", image: UIImage(named: C.vini)!, accountOwner: false),
                                      Story(username: "dev_dave", image: UIImage(named: C.followerProfilePicture)!, accountOwner: false),
                                      Story(username: "tech_head", image: UIImage(named: C.followerProfilePicture)!, accountOwner: false),
                                      Story(username: "zaragoza", image: UIImage(named: C.followerProfilePicture)!, accountOwner: false),
                                      Story(username: "tempo", image: UIImage(named: C.followerProfilePicture)!, accountOwner: false)]
    
    private var postArray:[Post] = [Post(profilePicture: UIImage(named: C.userProfilePicture)!, username: "imdavid10", location: "Phnom Penh, Cambodia", postImage: UIImage(named: "flower")!, totalLikes: 4, caption: "Happy Valentines day.", totalComment: 1, time: 0.5, like: true),
                                    Post(profilePicture: UIImage(named: C.vini)!, username: "vinijr", location: "Madrid, Spain", postImage: UIImage(named: C.vini)!, totalLikes: 4, caption: "⚡️", totalComment: 1, time: 0.5, like: true),
                                    Post(profilePicture: UIImage(named: C.cristinao)!, username: "cristiano", location: "Turin, Italy", postImage: UIImage(named: C.cristinao)!, totalLikes: 4, caption: "Picture from yesterday match!", totalComment: 3, time: 0.5, like: true),
                                    Post(profilePicture: UIImage(named: C.nikeLogo)!, username: "nike", location: "New York, United State of America", postImage: UIImage(named: C.nikeShoes)!, totalLikes: 4, caption: "Train like a pro.", totalComment: 1, time: 0.5, like: true)]
    
    @IBOutlet weak var tableView: UITableView!
    private let alert = AlertDialog()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeRecognizer()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: C.instagramFont, size: 35) ?? UIFont.systemFont(ofSize: 35)]
    }
        
    private func swipeRecognizer(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func respondToSwipe(with gesture:UISwipeGestureRecognizer){
        let transition = CATransition()
        
        if gesture.direction == .right{
            transition.duration         = 0.3
            transition.type             = CATransitionType.moveIn
            transition.subtype          = CATransitionSubtype.fromLeft
            transition.timingFunction   = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            
            let cameraVC = storyboard?.instantiateViewController(identifier: C.cameraVC) as! CameraViewController
            cameraVC.modalPresentationStyle = .fullScreen
            present(cameraVC, animated: false, completion: nil)
            
        }else if gesture.direction == .left{
            transition.duration         = 0.3
            transition.type             = CATransitionType.moveIn
            transition.subtype          = CATransitionSubtype.fromRight
            transition.timingFunction   = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            
            let messageVC = storyboard?.instantiateViewController(identifier: C.messageVC) as! MessageViewController
            messageVC.modalPresentationStyle = .fullScreen
            show(messageVC, sender: self)
        }
    }
    
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        let cameraVC = storyboard?.instantiateViewController(identifier: C.cameraVC) as! CameraViewController
        cameraVC.modalPresentationStyle = .fullScreen
        present(cameraVC, animated: false, completion: nil)
    }
    
    @IBAction func messageButton(_ sender: UIBarButtonItem) {
        let messageVC = storyboard?.instantiateViewController(identifier: C.messageVC) as! MessageViewController
        messageVC.modalPresentationStyle = .fullScreen
        show(messageVC, sender: self)
    }
    

} // End of class

//MARK: - Post TableView
extension HomeViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let storyCell = tableView.dequeueReusableCell(withIdentifier: C.storyTableViewCell, for: indexPath) as! StoryTableViewCell
            
            return storyCell
        }else{
            let postCell = tableView.dequeueReusableCell(withIdentifier: C.homeTableViewCell, for: indexPath) as! HomeTableViewCell
            postCell.profilePicture.image       = postArray[indexPath.row-1].profilePicture
            postCell.username.setTitle(postArray[indexPath.row-1].username, for: .normal)
            postCell.location.setTitle(postArray[indexPath.row-1].location, for: .normal)
            postCell.imageOfPost.image          = postArray[indexPath.row-1].postImage
            postCell.heartButton.setImage(postArray[indexPath.row-1].like == false ?  UIImage(named: C.heartButtonSelected) : UIImage(named: C.heartButtonUnselected), for: .normal)
            if postArray[indexPath.row-1].like == false{
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                    postCell.heartImageView.removeFromSuperview()
                }
            }else{
                postCell.heartImageView.removeFromSuperview()
            }
            postCell.totalLike.setTitle(String(postArray[indexPath.row-1].totalLikes)+" likes", for: .normal)
            postCell.secondUsername.setTitle(postArray[indexPath.row-1].username, for: .normal)
            postCell.caption.text = postArray[indexPath.row-1].caption
            postCell.comment.setTitle(postArray[indexPath.row-1].comment, for: .normal)
            postCell.time.text = postArray[indexPath.row-1].timePosted
            
            postCell.homeCellDelegate   = self
            postCell.postIndex  = indexPath.row-1
          
            return postCell
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 120
        }else{
            return UITableView.automaticDimension
        }
    }
}

//MARK: - Story CollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let storyCell = cell as? StoryTableViewCell {
                storyCell.storyCollectionView.delegate      = self
                storyCell.storyCollectionView.dataSource    = self
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let storyCell = collectionView.dequeueReusableCell(withReuseIdentifier: C.storyCollectionView, for: indexPath) as! StoryCollectionViewCell
        storyCell.storyBorder.layer.borderColor  = storyArray[indexPath.row].accountOwner ? UIColor.lightGray.cgColor: UIColor.red.cgColor
        storyCell.storyImage.image               = storyArray[indexPath.row].image
        storyCell.username.text                  = storyArray[indexPath.row].username
        
        return storyCell
    }
}

//MARK: - HomeTableViewCell's Protocol
extension HomeViewController: HomeVCButtonTap{
    
    func commentButtonTapped(postIndex: Int) {
        let commentVC = storyboard?.instantiateViewController(identifier: C.commentVC) as! CommentViewController
        commentVC.postOwner.append(postArray[postIndex])
        commentVC.currentUser.append(postArray[0])
        commentVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func editButtonTapped() {
        alert.alertSheet(on: self, buttonOne: "Unfollow", buttonTwo: "Mute", buttonThree: "Turn On Post Notifications", buttonFour: "Share to...", buttonFive: "Copy Link", buttonSix: "Report")
    }
    
    func heartButtonTapped(postIndex: Int) {
        if postArray[postIndex].like == true {
            postArray[postIndex].totalLikes     += 1
            postArray[postIndex].like           = false
        }else{
            postArray[postIndex].totalLikes     -= 1
            postArray[postIndex].like           = true
        }
        tableView.reloadData()
    }
}

