//
//  AddressModel.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/10/8.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class AddressModel: NSObject {
    var address:String?
    
    
    // KVC构造函数
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

    
}
