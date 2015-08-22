//
//  API.swift
//  taskyou
//
//  Created by 羽田 健太郎 on 2014/08/23.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit
/*

TASKAPI.login(NSDictionary(),
{(res:NSArray!)->Void in
NSLog("%@", res[0].description)
},
{(err:NSError!)->Void in

})

*/

/*
class TASKAPI: NSObject {
    class func checkins(
               success: ((NSArray!) -> Void)!,
               failure: ((NSError!) -> Void)!)->Void
    {
        var operationCtn:NSInteger = NetworkManager.sharedInstance.operationQueue.operationCount
        if(operationCtn == 0){
            var query = ["oauth_token":Foursquare2.accessToken(),"v":"20141006"]
            NetworkManager.sharedInstance.GET(
                "users/self/checkins",
                parameters: query,
                success:
                {(operaton:AFHTTPRequestOperation!, response:AnyObject!)->Void in
                    success(response?.objectForKey("response")?.objectForKey("checkins")?.objectForKey("items") as? NSArray)
                },
                failure:
                {(operation:AFHTTPRequestOperation!, err:NSError!)->Void in
                    failure(err)
                }
            )
        }
    }

    class func getVenue(
        lat:NSNumber,
        lng:NSNumber,
        success: ((NSArray!) -> Void)!,
        failure: ((NSError!) -> Void)!)->Void
    {
        var operationCtn:NSInteger = NetworkManager.sharedInstance.operationQueue.operationCount
        if(operationCtn == 0){
            var query = ["oauth_token":Foursquare2.accessToken(),"v":"20141006","ll":String(format:"%@,%@",lat,lng)]
            NetworkManager.sharedInstance.GET(
                "venues/search",
                parameters: query,
                success:
                {(operaton:AFHTTPRequestOperation!, response:AnyObject!)->Void in
                    success(response?.objectForKey("response")?.objectForKey("venues")? as? NSArray)
                },
                failure:
                {(operation:AFHTTPRequestOperation!, err:NSError!)->Void in
                    failure(err)
                }
            )
        }
    }
    
    class func updateCheck(query:NSDictionary!,
        success: ((NSDictionary!) -> Void)!,
        failure: ((NSError!) -> Void)!)
    {
        let manager = AFHTTPRequestOperationManager()
        manager.securityPolicy = AFSecurityPolicy.defaultPolicy()
        //manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET("http://www16095ui.sakura.ne.jp/yo/api/public/user/canUpdate", parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
//                println("response: \(responseObject.description)")
                success(responseObject as NSDictionary)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
//                println("error: \(error)")
        })
        
    }
    

}
*/
