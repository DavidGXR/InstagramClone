//
//  SearchViewController.swift
//  InstagramClone
//
//  Created by David Im on 11/30/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate    = self
        searchTableView.dataSource  = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
} // End of class


//MARK: - TableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let searchCell = tableView.dequeueReusableCell(withIdentifier: C.searchTableViewCell) as! SearchTableViewCell
            searchCell.searchTableViewCellDelegation = self
            
            return searchCell
        }else{
            let trendingCell = tableView.dequeueReusableCell(withIdentifier: C.trendingTableViewCell) as! TrendingTableViewCell
            trendingCell.photoAndVideoCollectionView.delegate   = self
            trendingCell.photoAndVideoCollectionView.dataSource = self
            
            return trendingCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            let imgSize = self.view.frame.width/3
            return (imgSize * 6)
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let trendingMenu = Bundle.main.loadNibNamed(C.trendingMenuHeader, owner: self, options: nil)?.first as! TrendingMenuHeader

        return trendingMenu
    }
}

//MARK: - CollectionView for images and videos
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let photoAndVideoCell = collectionView.dequeueReusableCell(withReuseIdentifier: C.trendingCollectionView, for: indexPath) as! TrendingCollectionViewCell
        photoAndVideoCell.trendingImageOrVideo.image = UIImage(named: C.userProfilePicture)
        
        return photoAndVideoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.bounds.width/3)
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

//MARK: - Show SearchAccountVC when user clikc on UISearchBar
extension SearchViewController: ShowContainerViewOnSearchVC {
    func showSearchAccountVC() {
        guard let searchAccountVC = storyboard?.instantiateViewController(identifier: "SearchAccountVC") as? SearchAccountViewController else{
            fatalError("Cannot instantiate SearchAccountViewController")
        }
        searchAccountVC.modalPresentationStyle = .fullScreen
        searchAccountVC.modalTransitionStyle   = .crossDissolve
        self.present(searchAccountVC, animated: true, completion: nil)
    }
}


