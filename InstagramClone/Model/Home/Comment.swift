//
//  Comment.swift
//  InstagramClone
//
//  Created by David Im on 11/12/20.
//  Copyright © 2020 David Im. All rights reserved.
//

import Foundation
import UIKit

struct Comment {
    
    let profileImage:UIImage
    let username:String
    let caption:String
    let time:Float
    var totalLike:Int
    var heart: Bool = false
    
    var timePosted:String{
        if time < 1.00{
            return String(format: "%.0f", time*10)+" seconds ago"
        }else if 1.00...60.00 ~= time{
            return String(format: "%.0f", time)+" minutes ago"
        }
        return String(format: "%.0f", time/60)+"h"
    }
    
    var like:String{
        if totalLike > 1{
            return "\(totalLike) likes"
        }else{
            return "\(totalLike) like"
        }
    }
}
