//
//  Network.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/11/07.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import Foundation

class Network{
    static func get(url: String, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "GET", callback: callback)
        manager.fire()
    }
    static func get(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "GET", params: params, callback: callback)
        manager.fire()
    }
    static func post(url: String, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "POST", callback: callback)
        manager.fire()
    }
    static func post(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "POST", params: params, callback: callback)
        manager.fire()
    }
}

extension String {
    var nsdata: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

struct File {
    let name: String!
    let url: NSURL!
    init(name: String, url: NSURL) {
        self.name = name
        self.url = url
    }
}

class NetworkManager: NSObject, NSURLSessionDelegate {
    let boundary = "PitayaUGl0YXlh"
    
    let method: String!
    let params: Dictionary<String, AnyObject>
    let callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void
    var files: Array<File>
    
    var session: NSURLSession!
    let url: String!
    var request: NSMutableURLRequest!
    var task: NSURLSessionTask!
    
    var localCertData: NSData!
    var sSLValidateErrorCallBack: (() -> Void)?
    
    init(url: String, method: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), files: Array<File> = Array<File>(), callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        self.url = url
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.method = method
        self.params = params
        self.callback = callback
        self.files = files
        
        super.init()
        self.session = NSURLSession(configuration: NSURLSession.sharedSession().configuration, delegate: self, delegateQueue: NSURLSession.sharedSession().delegateQueue)
    }
    func addSSLPinning(LocalCertData data: NSData, SSLValidateErrorCallBack: (()->Void)? = nil) {
        self.localCertData = data
        self.sSLValidateErrorCallBack = SSLValidateErrorCallBack
    }
    @objc func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        if let localCertificateData = self.localCertData {
            if let serverTrust = challenge.protectionSpace.serverTrust,
                certificate = SecTrustGetCertificateAtIndex(serverTrust, 0),
                remoteCertificateData: NSData = SecCertificateCopyData(certificate) {
                    if localCertificateData.isEqualToData(remoteCertificateData) {
                        let credential = NSURLCredential(forTrust: serverTrust)
                        challenge.sender?.useCredential(credential, forAuthenticationChallenge: challenge)
                        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
                    } else {
                        challenge.sender?.cancelAuthenticationChallenge(challenge)
                        completionHandler(NSURLSessionAuthChallengeDisposition.CancelAuthenticationChallenge, nil)
                        self.sSLValidateErrorCallBack?()
                    }
            } else {
                NSLog("Get RemoteCertificateData or LocalCertificateData error!")
            }
        } else {
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, nil)
        }
    }
    func fire() {
        buildRequest()
        buildBody()
        fireTask()
    }

    func buildRequest() {
        if self.method == "GET" && self.params.count > 0 {
            self.request = NSMutableURLRequest(URL: NSURL(string: url + "?" + buildParams(self.params))!)
        }
        
        request.HTTPMethod = self.method
        
        if self.files.count > 0 {
            request.addValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
        } else if self.params.count > 0 {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }
    func buildBody() {
        let data = NSMutableData()
        if self.files.count > 0 {
            if self.method == "GET" {
                NSLog("\n\n------------------------\nThe remote server may not accept GET method with HTTP body. But Pitaya will send it anyway.\n------------------------\n\n")
            }
            for (key, value) in self.params {
                data.appendData("--\(self.boundary)\r\n".nsdata)
                data.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".nsdata)
                data.appendData("\(value.description)\r\n".nsdata)
            }
            for file in self.files {
                data.appendData("--\(self.boundary)\r\n".nsdata)
                data.appendData("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(NSString(string: file.url.description).lastPathComponent)\"\r\n\r\n".nsdata)
                if let a = NSData(contentsOfURL: file.url) {
                    data.appendData(a)
                    data.appendData("\r\n".nsdata)
                }
            }
            data.appendData("--\(self.boundary)--\r\n".nsdata)
        } else if self.params.count > 0 && self.method != "GET" {
            data.appendData(buildParams(self.params).nsdata)
        }
        request.HTTPBody = data
    }
    //数据请求
    func fireTask() {
        task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            self.callback(data: data, response: response, error: error)
            
//            sleep(5)
            print(".............. 5 seconds!")
        })
        task.resume()
    }
    // 从 Alamofire 偷了三个函数,把url查询字符串中的一些特殊字符转换
    func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joinWithSeparator("&")
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
    
    
    //新方法  进行RFC3986编码,去除不安全字符
//    public func escape(string: String) -> String {
//        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
//        let subDelimitersToEncode = "!$&'()*+,;="
//        
//        let allowedCharacterSet = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
//        allowedCharacterSet.removeCharactersInString(generalDelimitersToEncode + subDelimitersToEncode)
//        
//        var escaped = ""
//        
//        //==========================================================================================================
//        //
//        //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
//        //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
//        //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
//        //  info, please refer to:
//        //
//        //      - https://github.com/Alamofire/Alamofire/issues/206
//        //
//        //==========================================================================================================
//        
//        if #available(iOS 8.3, OSX 10.10, *) {
//            escaped = string.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? string
//        } else {
//            let batchSize = 50
//            var index = string.startIndex
//            
//            while index != string.endIndex {
//                let startIndex = index
//                let endIndex = index.advancedBy(batchSize, limit: string.endIndex)
//                let range = startIndex..<endIndex
//                
//                let substring = string.substringWithRange(range)
//                
//                escaped += substring.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? substring
//                
//                index = endIndex
//            }
//        }
//        
//        return escaped
//    }
    
}
