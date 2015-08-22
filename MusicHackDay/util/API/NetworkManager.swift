//
//  NetworkManager.swift
//  taskyou
//
//  Created by 羽田 健太郎 on 2014/08/23.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit

class NetworkManager: AFHTTPRequestOperationManager {
    class var sharedInstance : NetworkManager {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : NetworkManager? = nil
        }
        dispatch_once(&Static.onceToken) {

            Static.instance = NetworkManager(baseURL: NSURL(string: "https://api.foursquare.com/v2/"))
            Static.instance?.securityPolicy = AFSecurityPolicy.defaultPolicy()
            
        }
        return Static.instance!
    }
}
