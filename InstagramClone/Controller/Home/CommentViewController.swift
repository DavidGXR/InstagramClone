//
//  CommentViewController.swift
//  InstagramClone
//
//  Created by David Im on 10/31/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var emojiOne: UIButton!
    @IBOutlet weak var emojiTwo: UIButton!
    @IBOutlet weak var emojiThree: UIButton!
    @IBOutlet weak var emojiFourth: UIButton!
    @IBOutlet weak var emojiFifth: UIButton!
    @IBOutlet weak var emojiSixth: UIButton!
    @IBOutlet weak var emojiSeventh: UIButton!
    @IBOutlet weak var emojiEighth: UIButton!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    private var postButton: UIButton!
    private var commentTextFieldRightView: UIView!
    
    private var postButtonWasShown = false
    private var isFinishedTouchOnEmojiButton = true
    private let alert = TextFieldUtils()
    private var comment = [Comment(profileImage: UIImage(named: C.followerProfilePicture)!, username: "cris", caption: "nice!", time: 0.3, totalLike: 0)]
    var postOwner = [Post]() // Get the data of current post
    var currentUser = [Post]() // This is just to get the name of current user & profie picture for comment section
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)]
    }
    
    @IBAction func emojiButtons(_ sender: UIButton) {
        if (postButtonWasShown != true) {
            showPostButton(state: true)
            postButtonWasShown = true
        }
        postButton.isUserInteractionEnabled = true
        if let title = sender.currentTitle{
            if isFinishedTouchOnEmojiButton == true {
                commentTextField.text = title
                isFinishedTouchOnEmojiButton = false
            }else{
                commentTextField.text?.append(title)
            }
        }
    }
    
    private func setupViews() {
        title = "Comments"
        commentTableView.rowHeight = 82
        userProfileImage.layer.cornerRadius = userProfileImage.frame.height/2
        userProfileImage.image = currentUser[0].profilePicture
        
        tableViewTapRecognizer()
        commentTableView.tableFooterView = UIView()
        
        commentTextFieldRightView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        commentTextField.addTarget(self, action: #selector(commentTextFieldTouchDown), for: .touchDown)
        commentTextField.addTarget(self, action: #selector(checkEmptyComment), for: .editingChanged)
        postButton = UIButton(frame: CGRect(x: 20, y: 0, width: 40, height: 40))
        postButton.addTarget(self, action:#selector(postComment) , for: .touchUpInside)
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(UIColor.systemTeal, for: .normal)
        postButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    // Hide keyboard when user tap on tableview cell
    private func tableViewTapRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        commentTableView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        commentTextField.endEditing(true)
        if let comment = commentTextField.text {
            if (comment.isEmpty) {
                showPostButton(state: false)
            }
        }
    }
    
    // Hide keyboard when user tap on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if let comment = commentTextField.text {
            if (comment.isEmpty) {
                showPostButton(state: false)
            }
        }
    }
    
    // Add post button to commentTextField and provide functionality when user tap on the button
    private func showPostButton(state:Bool){
   
        commentTextFieldRightView.addSubview(postButton)
        commentTextField.rightView = commentTextFieldRightView
        
        if state == true {
            commentTextField.rightViewMode = UITextField.ViewMode(rawValue: 3)! // show post button
        }else{
            commentTextField.rightViewMode = UITextField.ViewMode(rawValue: 0)! // hide post button
        }
    }
    
    @objc private func postComment(){
        if let commentFromOwner = commentTextField.text{
            comment.insert(Comment(profileImage: currentUser[0].profilePicture, username: currentUser[0].username, caption: commentFromOwner, time: 0.10, totalLike: 0), at: 0)
        }
        commentTextField.text?.removeAll()
        commentTextField.resignFirstResponder()
        showPostButton(state: false)
        postButtonWasShown = false
        commentTableView.reloadData()
    }
    
    @objc private func checkEmptyComment() {
        guard let commentText = commentTextField.text, !commentText.isEmpty else {
            postButton.isUserInteractionEnabled = false
            return
        }
        postButton.isUserInteractionEnabled = true
    }
    
    @objc private func commentTextFieldTouchDown(){
        if let commentText = commentTextField.text {
            if commentText.isEmpty {
                postButton.isUserInteractionEnabled = false
                showPostButton(state: true)
                postButtonWasShown = true
            }
        }
    }
    
}// Ends of class

//MARK: - TableViewDataSource & TableViewDelegate
extension CommentViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let userCell              = tableView.dequeueReusableCell(withIdentifier: C.userCellInCommentSection) as! CommentTableViewCell
            userCell.profileImage.image = postOwner[indexPath.row].profilePicture
            userCell.username.setTitle(postOwner[indexPath.row].username, for: .normal)
            userCell.caption.text       = postOwner[indexPath.row].caption
            userCell.time.text          = postOwner[indexPath.row].timePosted
            return userCell
        }else{
            let followerCommentCell = tableView.dequeueReusableCell(withIdentifier: C.followerCellInCommentSection) as! CommenterTableViewCell
            followerCommentCell.profileImage.image = comment[indexPath.row-1].profileImage
            followerCommentCell.username.setTitle(comment[indexPath.row-1].username, for: .normal)
            followerCommentCell.caption.text       = comment[indexPath.row-1].caption
            followerCommentCell.time.text          = comment[indexPath.row-1].timePosted
            followerCommentCell.like.text          = comment[indexPath.row-1].like
            followerCommentCell.heartButton.setImage(comment[indexPath.row-1].heart == true ? UIImage(named: C.heartButtonSelected): UIImage(named: C.heartButtonUnselected), for: .normal)
            
            followerCommentCell.commentIndex = indexPath.row
            followerCommentCell.commentCellDelegate = self
            
            return followerCommentCell
        }
    }
}

//MARK: - Delegate Methods From CommenterTableViewCell
extension CommentViewController:CommentVCButtonTap{
    func heartButtonTap(index: Int) {
        if comment[index-1].heart == false {
            comment[index-1].totalLike += 1
            comment[index-1].heart = true
        }else{
            comment[index-1].totalLike -= 1
            comment[index-1].heart = false
        }
        commentTableView.reloadData()
    }
}

