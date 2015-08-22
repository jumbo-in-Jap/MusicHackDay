//
//  util.swift
//  TodoSquare
//
//  Created by 羽田 健太郎 on 2014/10/06.
//  Copyright (c) 2014年 羽田 健太郎. All rights reserved.
//

import UIKit

let DIST_NOTIF:Double = 200
let DEF_KEY_FSCHECK = "def_fs_key"
class util: NSObject {

    class func showAlert(title:String, message:String, successHandler:()->Void)
    {
        var alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in
            successHandler()
        }
        let cancelAction = UIAlertAction(title: "NO", style: .Cancel) {
            action in
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        // 現在のViewController
        var topController:UIViewController! = UIApplication.sharedApplication().keyWindow?.rootViewController
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        topController.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
