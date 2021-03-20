//
//  LoadingIndicator.swift
//  InstagramClone
//
//  Created by David Im on 11/17/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import UIKit

class LoadingIndicatorAlert{
    
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
    private let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))

    func startActivityIndicator(color: UIColor){
        activityIndicator.color = color
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
        
    func startActivityIndicatorOverlayView(view:UIView, color: UIColor){
        viewBackgroundLoading.center = view.center
        viewBackgroundLoading.backgroundColor = UIColor.black
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        viewBackgroundLoading.addSubview(activityIndicator)
        
        activityIndicator.center = CGPoint(x: viewBackgroundLoading.frame.size.width/2, y: viewBackgroundLoading.frame.size.height/2)
        view.addSubview(viewBackgroundLoading)
        
        activityIndicator.isHidden = false
        viewBackgroundLoading.isHidden = false
        startActivityIndicator(color: color)
    }
    
    func stopActivityIndicatorOverlayView(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.viewBackgroundLoading.isHidden = true
        }
    }
}

