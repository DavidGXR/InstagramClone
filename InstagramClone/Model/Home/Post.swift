//
//  Post.swift
//  InstagramClone
//
//  Created by David Im on 10/29/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import UIKit

struct Post{
    let profilePicture:UIImage
    let username:String
    let location:String
    let postImage:UIImage
    var totalLikes:Int
    let caption:String
    let totalComment:Int
    let time:Float
    var like:Bool = false
        
    var timePosted:String{
        if time < 1.00{
            return String(format: "%.0f", time*10)+" seconds ago"
        }else if 1.00...60.00 ~= time{
            return String(format: "%.0f", time)+" minutes ago"
        }
        return "\(time/60) hours ago"
    }
    
    var comment:String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let totalComments = numberFormatter.string(from: NSNumber(value: totalComment)) ?? "0"
        return "View all \(totalComments) comments"
    }
}
