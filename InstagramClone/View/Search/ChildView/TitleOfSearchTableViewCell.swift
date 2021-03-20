//
//  TitleOfSearchTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 12/4/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class TitleOfSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleOfSearch: UILabel!
    @IBOutlet weak var seeAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func seeAllButton(_ sender: UIButton) {
    }
}
