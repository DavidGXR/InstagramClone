//
//  PhotosTableViewCell.swift
//  InstagramClone
//
//  Created by David Im on 11/22/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import UIKit

protocol PhotoTableViewCellDelegateMethods{
    func segmentControl(index: Int, collectionView: UICollectionView)
}

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photoCellDelegate:PhotoTableViewCellDelegateMethods?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSwipeRecognizer()
    }
    
    private func collectionViewSwipeRecognizer(){
        let rightToLeftGestureRecognizer        = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        let leftToRightGestureRecognizer        = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        
        leftToRightGestureRecognizer.direction  = .right
        rightToLeftGestureRecognizer.direction  = .left
        
        photoCollectionView.addGestureRecognizer(rightToLeftGestureRecognizer)
        photoCollectionView.addGestureRecognizer(leftToRightGestureRecognizer)
    }
    
    @objc private func respondToSwipe(gesture: UISwipeGestureRecognizer){
        
        if gesture.direction == .left{
            segmentControl.selectedSegmentIndex = 1
            photoCellDelegate?.segmentControl(index: 1, collectionView: photoCollectionView)
        }else{
            segmentControl.selectedSegmentIndex = 0
            photoCellDelegate?.segmentControl(index: 0, collectionView: photoCollectionView)
        }
    }

    @IBAction func segmentControlButton(_ sender: UISegmentedControl) {
        photoCellDelegate?.segmentControl(index: sender.selectedSegmentIndex, collectionView: photoCollectionView)
    }
}
