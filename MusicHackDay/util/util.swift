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
    
    func getCheckins()
    {
        var comp: NSDateComponents = NSDateComponents()
        comp.year = -3
        var befDate:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(comp, toDate: NSDate(), options: nil)!
        
        Foursquare2.userGetCheckins("self", limit: 100, offset: 0, sort: FoursquareCheckinsSort.NewestFirst, after: NSDate(), before: befDate, callback: {(res:Bool, resObj:AnyObject!)->Void in
            //NSLog("%@", resObj as NSDictionary)
        })
    }
    
    class func setNotification(center:CLLocationCoordinate2D, title:String, id:String)
    {        
        //NSLog("set notification:%f,%f - %@",center.latitude,center.longitude, id)
        var locNotification:UILocalNotification = UILocalNotification()
        locNotification.regionTriggersOnce = true
        locNotification.alertBody=title
        locNotification.userInfo = ["id":id];
        locNotification.category = "custom"
        locNotification.region = CLCircularRegion(circularRegionWithCenter: center, radius: 100.0, identifier: "delete")
        UIApplication.sharedApplication().scheduleLocalNotification(locNotification)
    }
    
    class func setImmidNotification(title:String,id:String)
    {
        var isAlreadySet = false
        var notifications:[UILocalNotification] = UIApplication.sharedApplication().scheduledLocalNotifications as [UILocalNotification]
        for notif:UILocalNotification in notifications
        {
            if let userInfo = notif.userInfo{
                if let value: AnyObject = userInfo["id"]
                {
                    if value as String == id
                    {
                        isAlreadySet = true
                    }
                }
            }
        }

        if !isAlreadySet
        {
            var locNotification:UILocalNotification = UILocalNotification()
            locNotification.regionTriggersOnce = true
            locNotification.alertBody=title
            locNotification.userInfo = ["id":id];
            locNotification.category = "custom"
            locNotification.soundName = UILocalNotificationDefaultSoundName
            locNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
            UIApplication.sharedApplication().scheduleLocalNotification(locNotification)
        }
    }
    
    class func checkLocalNotificationSchedule()
    {
        //self.resetLocalNotificationSchedule()
        var notifications:[UILocalNotification] = UIApplication.sharedApplication().scheduledLocalNotifications as [UILocalNotification]
        //NSLog("Notifications : %d", notifications.count)
        for notif:UILocalNotification in notifications
        {
            NSLog("%@", notif.description)
        }
    }
    
    class func resetLocalNotificationSchedule()
    {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    class func deleteId(timeId:String, withSave:Bool)
    {
        var t:Task = Task.MR_findFirstByAttribute("t_id", withValue: timeId) as Task
        t.MR_deleteEntity()
        var notifications:[UILocalNotification] = UIApplication.sharedApplication().scheduledLocalNotifications as [UILocalNotification]
        //NSLog("Notifications : %d", notifications.count)
        for notif:UILocalNotification in notifications
        {
            if let userInfo = notif.userInfo{
                if let value: AnyObject = userInfo["id"]
                {
                    if value as NSString == timeId
                    {
                        UIApplication.sharedApplication().cancelLocalNotification(notif)
                    }
                }
            }
        }
        
        
        if withSave
        {
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        }
    }
    
}
