//
//  SearchTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 12/1/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

protocol ShowContainerViewOnSearchVC {
    func showSearchAccountVC()
}

class SearchTableViewCell: UITableViewCell{
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchTableViewCellDelegation:ShowContainerViewOnSearchVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor    = .white
        searchBar.delegate        = self
    }
}

extension SearchTableViewCell: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchTableViewCellDelegation?.showSearchAccountVC()
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        return true
    }
}
