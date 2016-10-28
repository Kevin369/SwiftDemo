//
//  Networktools.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/30.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import AFNetworking
// 请求方式枚举
enum MethodType: String {
    case GET = "GET"
    case POST = "POST"
}
class Networktools: AFHTTPSessionManager {
    // 全局访问点
    static let sharedTools:Networktools = {
        let tools = Networktools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    // 给我们成功的闭包和失败的闭包格式起别名
    typealias SuccessClosure = (response: AnyObject?)->()
    typealias FailureClosure = (error: NSError)->()
    //
    /**
     请求数据方法
     
     - parameter method:     方式
     - parameter urlString:  url
     - parameter parameters: 参数
     - parameter success:    成功
     - parameter failure:    失败
     */
    func request(method:MethodType, urlString: String, parameters: AnyObject?, success: SuccessClosure, failure: FailureClosure){
        // GET 请求
        if method == .GET {
            self.GET(urlString, parameters: parameters, progress: nil, success: { (_, res) -> Void in
                success(response: res)
                }, failure: { (_, err) -> Void in
                    failure(error: err)
                    
            })
        }else {
            // POST 请求
            self.POST(urlString, parameters: parameters, progress: nil, success: { (_, res) -> Void in
                success(response: res)
                }, failure: { (_, err) -> Void in
                    failure(error: err)
                    
            })
        }
    }
}



