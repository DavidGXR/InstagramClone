//
//  TrendingMenuHeader.swift
//  InstagramClone
//
//  Created by David Im on 12/1/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

class TrendingMenuHeader: UITableViewCell {

    @IBOutlet weak var trendingMenuCollectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    private let trendingMenuArray = ["IGTV", "Shop", "Travel", "Architecutre", "Decore", "Art", "Food", "Style", "TV & Movie", "DIY", "Music", "Sports", "Beauty"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        trendingMenuCollectionView.delegate     = self
        trendingMenuCollectionView.dataSource   = self
        
        self.trendingMenuCollectionView.register(UINib.init(nibName: C.trendingMenuCollectionViewFile, bundle: nil), forCellWithReuseIdentifier: C.trendingMenuCollectionView)
    }
}

extension TrendingMenuHeader: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMenuArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let trendingMenu = collectionView.dequeueReusableCell(withReuseIdentifier: C.trendingMenuCollectionView, for: indexPath) as! TrendingMenuCollectionViewCell
        trendingMenu.menuButton.setTitle(trendingMenuArray[indexPath.row], for: .normal)
        return trendingMenu
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 35.0)
    }
}


