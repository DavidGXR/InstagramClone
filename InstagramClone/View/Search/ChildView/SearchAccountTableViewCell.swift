//
//  SearchAccountTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 12/4/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

protocol ButtonTapOnSearchAccountTableViewCell {
    func deleteSearchHistory(index: Int)
}

class SearchAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    private let storyView: UIView = UIView()
    
    var searchAccountTableViewCellDelegation:ButtonTapOnSearchAccountTableViewCell?
    var indexOfSearchHistory:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage.layer.cornerRadius = userImage.frame.height / 2
    }
    
    @IBAction func deleteSearchHistory(_ sender: UIButton) {
        searchAccountTableViewCellDelegation?.deleteSearchHistory(index: indexOfSearchHistory ?? 0)
    }
}
