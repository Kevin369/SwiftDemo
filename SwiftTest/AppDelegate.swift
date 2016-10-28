//
//  AppDelegate.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var imageView = UIImageView()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        requestADImage()
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.redColor()
        window?.rootViewController = MainRootViewController()
        window?.makeKeyAndVisible()
        imageView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H)
        
        readWithFile()
        
        self.window?.addSubview(imageView)

        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector:#selector(AppDelegate.timeOut), userInfo: nil, repeats: false)
    
        

        // Override point for customization after application launch.
        return true
    }
    
    func timeOut() {
        imageView.removeFromSuperview()

    }
    
    
    func requestADImage() {
        let urlStr = ""//公司借口不方便暴露,抱歉
        
        Alamofire.request(.GET, urlStr,parameters: [:]).responseJSON { (response) in
            switch response.result {
            case .Success:
                print(response)
                //把得到的JSON数据转为字典
                if let j = response.result.value as? NSDictionary{
                    let name = UIDevice.currentDevice().name
                     print(name)
//                    var imageURL = String ()
//                    if name = 5S

                    
                    
                    if   let picURL = j.valueForKey("LaunchImage_1242_2208")as? String {
                        

                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                            self.downLoadImage(picURL)
                        }
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
    
    func downLoadImage(str:String){
        if let url = NSURL(string: str) {
            if let data = NSData(contentsOfURL: url){
                let img = UIImage(data: data)
                let home = NSHomeDirectory() as NSString
                print(home)
                let docPath = home.stringByAppendingPathComponent("Documents") as NSString
                let filePath = docPath.stringByAppendingPathComponent("666.png")
                do {
                     try UIImagePNGRepresentation(img!)?.writeToFile(filePath, options: NSDataWritingOptions.DataWritingAtomic)
                }catch _{
                    print("存储闪屏图片错误")
                }
          }
        
       }
    }
    
    
    
    
    func readWithFile() {
        let home = NSHomeDirectory() as NSString;
        let docPath = home.stringByAppendingPathComponent("Documents") as NSString;
        /// 获取文本文件路径
        let filePath = docPath.stringByAppendingPathComponent("666.png");
        let image = UIImage.init(contentsOfFile: filePath)
        if image == nil {
            imageView.image = UIImage(named: "333.jpg")
        }else{
            imageView.image = image
        }
        
        print(filePath)
    }
 

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }



}
