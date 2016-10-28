//
//  Header.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//
import UIKit
import Foundation
let SCREEN_W = UIScreen.mainScreen().bounds.width
let SCREEN_H = UIScreen.mainScreen().bounds.height

let Nav_H:CGFloat = 64

let TabBar_H:CGFloat = 49

let iOS_VERSION = (UIDevice.currentDevice().systemVersion as NSString).doubleValue

func RGBA(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat)->UIColor{
    
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha:A)
    
}

func NSLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line)
{
    #if DEBUG
        //    print("\((fileName as NSString).pathComponents.last!).\(methodName)[\(lineNumber)]:\(message)")
        print("\(methodName)[\(lineNumber)]:\(message)")
    #endif
}