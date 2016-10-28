//
//  MainRootViewController.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class MainRootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建子控制器
        addChildViewControllers()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    //MARK: - 懒加载
//    lazy var composeBtn :UIButton = {
//        let btn = UIButton()
//        //背景图片
//        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
//        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
//        //设置图片
//        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
//        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
//        //设置尺寸
//        btn.sizeToFit()//根据内容调整尺寸!!
//        return btn
//    }()
    
    
    /**
     添加所有的子控制器
     */
    private func addChildViewControllers()  {
        addChideVCs()
    }

    private  func addChideVCs()  {
        // 按照默认方式加载页面!!
        addChildViewController("HomeViewController", title: "首页", imageName: "tabbar_home")
        addChildViewController("SecViewController", title: "第二", imageName: "tabbar_message_center")
        addChildViewController("ThirdViewController", title: "第三", imageName: "tabbar_discover")
        addChildViewController("MyViewController", title:
            "我的", imageName: "tabbar_profile")
    }
    
    private  func addChildViewController(childControllerNamed: String,title:String ,imageName:String) {
        
        guard let proName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else{
            return
        }
        // 拼接字符串,获取类类型
        guard let cls = NSClassFromString(proName + "." + childControllerNamed) else{
            return
        }
        guard let clsType = cls as? UIViewController.Type else{
            return
        }
        let childController = clsType.init()
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
        
    }


}
