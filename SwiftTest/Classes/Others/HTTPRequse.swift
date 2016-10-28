//
//  HTTPRequse.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/10/13.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import Foundation
import Alamofire
//创建请求类枚举
enum RequestType: Int {
    case requestTypeGet
    case requestTypePost
}

//创建一个闭包
typealias sendVlesClosure = (AnyObject?, NSError?)->Void
typealias uploadClosure = (AnyObject?, NSError?,Int64?,Int64?,Int64?)->Void
class HTTPRequse {
    
    // --GET请求获取JSON数据
    static  func GetJSONDataWithUrl(url: String, parameters: AnyObject, successed:(responseObject: AnyObject?) -> (), failed: (error: NSError?) -> ()) {
        
        Alamofire.request(.GET, url, parameters: parameters as? [String : AnyObject]).responseJSON { (data: Response<AnyObject, NSError>) in
            if data.result.isSuccess {
                successed(responseObject: data.data)
            }else {
                failed(error: data.result.error)
            }
        }
    }
    
    // --POST请求获取JSON数据
    func PostJSONDataWithUrl(url: String,parameters: AnyObject,successed:(responseObject: AnyObject?) -> (), failed: (error: NSError?) -> ()) {
        //print(parameters)
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject]).responseJSON { (data: Response<AnyObject, NSError>) in
            if data.result.isSuccess {
                successed(responseObject: data.data)
            }else {
                failed(error: data.result.error)
            }
        }
        
    }
    
    // --文件上传
    //fileURL实例:let fileURL = NSBundle.mainBundle().URLForResource("Default",withExtension: "png")
    func Upload(URLString:String,fileURL:NSURL,progress:(bytesWritten: Int64?,totalBytesWritten: Int64?,totalBytesExpectedToWrite: Int64?) -> Void, responseResult:(responseValue: AnyObject?,error: NSError?) -> Void) {
        
        Alamofire.upload(.POST, URLString, file: fileURL).progress {(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
            progress(bytesWritten:bytesWritten,totalBytesWritten:totalBytesWritten,totalBytesExpectedToWrite:totalBytesExpectedToWrite)
            }.responseJSON { response in
                responseResult(responseValue:response.result.value,error:response.result.error)
        }
    }
    /*
     ** 写法二  block定义成宏的写法
     //fileURL实例:let fileURL = NSBundle.mainBundle().URLForResource("Default",withExtension: "png")
     func Upload(URLString:String,fileURL:NSURL,block:uploadClosure) {
     
     Alamofire.upload(.POST, URLString, file: fileURL).progress {(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
     block(nil,nil,bytesWritten ,totalBytesWritten,totalBytesExpectedToWrite)
     }.responseJSON { response in
     block(response.result.value,response.result.error,nil,nil,nil)
     }
     }
     
     
     */
    
    // --文件下载
    //下载到默认路径let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    //默认路径可以设置为空,因为有默认路径
    func Download(type:RequestType,URLString:String,progress:(bytesRead: Int64?,totalBytesRead: Int64?,totalBytesExpectedToRead: Int64?) -> Void, responseResult:(responseValue: AnyObject?,error: NSError?) -> Void) {
        switch type {
        case .requestTypeGet:
            Alamofire.download(.GET, URLString, destination: destination)
                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                    progress(bytesRead:bytesRead,totalBytesRead:totalBytesRead,totalBytesExpectedToRead:totalBytesExpectedToRead)
                }
                .response { (request, response, _, error) in
                    responseResult(responseValue:response,error:error)
            }
            break
        case .requestTypePost:
            Alamofire.download(.POST, URLString, destination: destination)
                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                    progress(bytesRead:bytesRead,totalBytesRead:totalBytesRead,totalBytesExpectedToRead:totalBytesExpectedToRead)
                }
                .response { (request, response, _, error) in
                    responseResult(responseValue:response,error:error)
            }
        }
    }
    
    /* block定义成宏的写法
     
     let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
     //默认路径可以设置为空,因为有默认路径
     func Download(type:RequestType,URLString:String,block:uploadClosure) {
     switch type {
     case .requestTypeGet:
     Alamofire.download(.GET, URLString, destination: destination)
     .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
     
     block(nil,nil,bytesRead, totalBytesRead, totalBytesExpectedToRead)
     }
     .response { (request, response, _, error) in
     block(response,error,nil,nil,nil)
     }
     break
     case .requestTypePost:
     Alamofire.download(.POST, URLString, destination: destination)
     .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
     block(nil,nil,bytesRead, totalBytesRead, totalBytesExpectedToRead)
     }
     .response { (request, response, _, error) in
     block(response,error,nil,nil,nil)
     }
     }
     }
     
     */
    
    // --上传多张图片
    func BLPostUploadMultiPicture(url: String, parameters: AnyObject, imgParameters: [UIImage]?, successed:(responseObject: AnyObject?) -> (), failed: (error: NSError?) -> ()) {
        Alamofire.upload(.POST, url, headers: parameters as? [String : String], multipartFormData: { (formData) in
            for index in 0..<imgParameters!.count {
                
                let imageData = UIImagePNGRepresentation(imgParameters![index] )
                formData.appendBodyPart(data: imageData!, name: "img\(index)", fileName: "\(index).jpg", mimeType: "image/png")
            }
        }, encodingMemoryThreshold: Manager.MultipartFormDataEncodingMemoryThreshold){ (result) in
            switch result {
            case .Success(let upload, _, _):
                upload.responseJSON{ respone in
                    print(respone.data)
                    successed(responseObject: respone.data)
                    
                }
            case .Failure(let error):
                
                print(error)
                
                break
            }
        }
    }

}