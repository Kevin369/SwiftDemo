//
//  TabView.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/11/2.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

protocol tabClickDelegate {
    func btnClick()
}


class TabView: UIView,UIScrollViewDelegate {
    var imageView = UIImageView()
    var scrollview = UIScrollView()
    var selectTag:Int?
    var array = NSArray()
    var delegate:tabClickDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectTag = -1
    }




    convenience init (frame:CGRect , array:NSArray) {
        self.init(frame:frame)
        self.array = array
//        let image = UIImage(named: "bj")
        
//        self.imageView.image = image
//        self.imageView.frame = CGRectMake(0, 0, SCREEN_W, 50)
//        imageView.userInteractionEnabled = ture
//        imageView.backgroundColor = UIColor.blackColor()
        self.addSubview(imageView)
        
        
        self.scrollview.frame = CGRectMake(0, 0, SCREEN_W, 50)
        self.scrollview.showsHorizontalScrollIndicator = false
        self.scrollview.showsVerticalScrollIndicator = false
//        self.scrollview.delegate = self
        self.scrollview.clipsToBounds = true
//        scrollview.backgroundColor = UIColor.greenColor()
        self.addSubview(self.scrollview)
        let width:CGFloat = SCREEN_W/3
        
//        if array.count == 1 {
//            width = SCREEN_W
//        }else if array.count == 2 {
//            self.scrollview.frame = CGRectMake(0, 0, width*2, self.scrollview.frame.size.height)
//            self.scrollview.center = CGPointMake(SCREEN_W/2, self.scrollview.frame.size.height/2)
//        }
        
        let height:CGFloat = 50
        
        for i in 0..<array.count {
//            width+ =? width
            
            let btn: UIButton! = UIButton(type: UIButtonType.Custom)
            btn.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            btn.backgroundColor = UIColor.blackColor()
            btn.setTitle(self.array[i] as? String, forState: UIControlState.Normal)
            print(btn.titleLabel?.text)
            btn.backgroundColor = UIColor.lightGrayColor()
//            btn.setTitle(array[i], forState: UIControlState.Normal)
            btn.tag = 1000+i
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            btn.addTarget(self, action: #selector(tabClickAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollview.addSubview(btn)
            self.scrollview.contentSize = CGSizeMake(btn.frame.size.width + btn.frame.origin.x, 0)
            let lineView = UIView()
//            let size:CGSize = <#value#>
            
            lineView.frame = CGRectMake(0, 0, 50, 2)
            lineView.tag = 2000+i
            lineView.center = CGPointMake(btn.center.x, btn.frame.size.height-1)
            self.scrollview.addSubview(lineView)
            
            if i == 0 {
                btn .setTitleColor(UIColor.orangeColor(), forState: .Normal)
                lineView.backgroundColor = UIColor.orangeColor()
            }else{
                btn .setTitleColor(UIColor.grayColor(), forState: .Normal)
                 lineView.backgroundColor = UIColor.clearColor()
            }
            
            
            
            
        }


//        var button = UIButton()
//        button = (self.viewWithTag(1000) as?  UIButton)!
//        self.tabClickAction(button)
//    
    
}
    
    
    //点击Tab按钮切换
    func tabClickAction(btn:UIButton) {
        print(btn.tag)
        let tag:Int = btn.tag - 1000
        if self.selectTag == tag {
            return
        }
        self.selectTag = tag
        for i in 0..<self.array.count {
            var view = UIView()
            view = self.viewWithTag(2000+i)!
            var button = UIButton()
            button = (self.viewWithTag(1000+i) as?  UIButton)!
            if i == tag {
                button .setTitleColor(UIColor.orangeColor(), forState: .Normal)
                view.backgroundColor = UIColor.orangeColor()

            }else{
                button .setTitleColor(UIColor.grayColor(), forState: .Normal)
                view.backgroundColor = UIColor.clearColor()

            }
            
        }
        
        
        if (self.array.count > 3 && tag >= 2) {
            if tag == self.array.count - 1 {
                self.scrollview.setContentOffset(CGPointMake(btn.frame.origin.x-(btn.frame.size.width*2), 0), animated: true)
            }
            else{
                self.scrollview.setContentOffset(CGPointMake(btn.frame.origin.x-btn.frame.size.width, 0), animated: true)
            }
        }else if tag == 1 {
            self.scrollview.setContentOffset(CGPointMake(btn.frame.origin.x-btn.frame.size.width, 0), animated: true)
        }
        
        self.delegate?.btnClick()
    }
    
//    func labelText(text:NSString , size:float , width:CGFloat) -> CGSize {
//        let sent = {NSFontAttributeName:}
//        
//    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
