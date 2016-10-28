//
//  UIButton+Extention.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    convenience init(imageName:String,backgroundImageName:String){
        self.init()
        //设置图片
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        //设置背景图片
        setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), forState: .Highlighted)
        //设置尺寸
        sizeToFit()
    }
    
    
    
}