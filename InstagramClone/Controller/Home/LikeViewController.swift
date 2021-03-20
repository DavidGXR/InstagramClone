//
//  LikeViewController.swift
//  InstagramClone
//
//  Created by David Im on 11/17/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

final class LikeViewController: UIViewController {
    
    @IBOutlet weak var likeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var likers:[Like] = [Like(profileImage: UIImage(named: C.followerProfilePicture)!, username: "cristiano", name: "Cristiano Ronaldo"),
                                 Like(profileImage: UIImage(named: C.followerProfilePicture)!, username: "lukam10", name: "Luka Modric"),
                                 Like(profileImage: UIImage(named: C.followerProfilePicture)!, username: "vathanaka_cv11", name: "Chan Vathanaka"),
                                 Like(profileImage: UIImage(named: C.followerProfilePicture)!, username: "salt_bae", name: "Nusret")]
    private var filterData     = [Like]()
    private var filterHasValue = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Likes"
        
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)]
    }
}

extension LikeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filterData.isEmpty{
            return filterData.count
        }
        return filterHasValue ? likers.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.likeCell, for: indexPath) as! LikeTableViewCell
        
        if !filterData.isEmpty{
            cell.profileImage.image = filterData[indexPath.row].profileImage
            cell.username.text      = filterData[indexPath.row].username
            cell.name.text          = filterData[indexPath.row].name
        }else{
            cell.profileImage.image = likers[indexPath.row].profileImage
            cell.username.text      = likers[indexPath.row].username
            cell.name.text          = likers[indexPath.row].name
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}

extension LikeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filterData = likers
        }else{
            filterData.removeAll()
            for name in likers{
                if name.username.lowercased().contains(searchText.lowercased()){
                    filterData.append(name)
                }else{
                    filterHasValue = false
                }
            }
        }
        likeTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
