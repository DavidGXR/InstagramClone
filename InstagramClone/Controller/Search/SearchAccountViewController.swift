//
//  SearchAccountViewController.swift
//  InstagramClone
//
//  Created by David Im on 12/4/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class SearchAccountViewController: UIViewController {

    @IBOutlet private weak var searchAccountTableView: UITableView!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    private var searchHistoryData = [Search(name: "Im David", username: "imdavid10", profileImage: UIImage(named: C.userProfilePicture)!),
                                 Search(name: "Cristiano Ronaldo", username: "cristiano", profileImage: UIImage(named: C.userProfilePicture)!),
                                 Search(name: "Vinicius JR", username: "vinijr", profileImage: UIImage(named: C.followerProfilePicture)!),
                                 Search(name: "Justin Bieber", username: "justinbieber", profileImage: UIImage(named: C.followerProfilePicture)!),
                                 Search(name: "Marques Brownlee", username: "mkbhd", profileImage: UIImage(named: C.followerProfilePicture)!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchAccountTableView.separatorStyle = .none
        searchAccountTableView.estimatedRowHeight = 100
        searchAccountTableView.rowHeight = UITableView.automaticDimension
        
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .none
        
    }
    override func viewWillAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
    }
    
    @IBAction private func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func segmentControlAction(_ sender: UISegmentedControl) {
    }
}

//MARK: - TableView
extension SearchAccountViewController: UITableViewDataSource, UITableViewDelegate {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return searchHistoryData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if indexPath.section == 0{
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "titleOfSearchCell") as! TitleOfSearchTableViewCell
            titleCell.titleOfSearch.text = "Recently"
            titleCell.seeAll.setTitle("See All", for: .normal)
        
            if searchHistoryData.isEmpty {
                titleCell.titleOfSearch.isHidden = true
                titleCell.seeAll.isHidden        = true
            } else {
                titleCell.titleOfSearch.isHidden = false
                titleCell.seeAll.isHidden        = false
            }
            
            return titleCell
       }else{
            let searchHistory = tableView.dequeueReusableCell(withIdentifier: "searchAccountCell") as! SearchAccountTableViewCell
            searchHistory.userImage.image  = searchHistoryData[indexPath.row].profileImage
            searchHistory.username.text    = searchHistoryData[indexPath.row].username
            searchHistory.name.text        = searchHistoryData[indexPath.row].name
            
            searchHistory.searchAccountTableViewCellDelegation = self
            searchHistory.indexOfSearchHistory = indexPath.row
            
            return searchHistory
        }
    }
}

extension SearchAccountViewController: ButtonTapOnSearchAccountTableViewCell {
    func deleteSearchHistory(index: Int) {
        searchHistoryData.remove(at: index)
        searchAccountTableView.reloadData()
    }
}
