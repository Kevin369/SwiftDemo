//
//  HearerView.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/10/21.
//  Copyright © 2016年 Kevin. All rights reserved.
//
//
//import UIKit
//let tabNameArray = ["品牌","男士","女士","家居","东方"]
//class HearerView: UIView ,UIScrollViewDelegate{
//    var tabCallBark:(index:Int)->Void
//    var tabScrollView:UIScrollView!
//    var currentIndex:Int!
//    var tabSaveArray:Array<UIButton>?
//    var leftSwipeGestureRecognizer:UISwipeGestureRecognizer?
//    var rightSwipeGestureRecognizer:UISwipeGestureRecognizer?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        
//        let tabScrollView = UIScrollView.init(frame: CGRectMake(0, 60 , SCREEN_W, 40))
//        addSubview(tabScrollView)
//        tabScrollView.delegate = self
//        tabScrollView.showsHorizontalScrollIndicator = false
//        //tabScrollView.scrollEnabled = false
//        self.tabScrollView = tabScrollView
//        var tabBtnWidth:CGFloat = 70
//        var marginX:CGFloat = SCREEN_W*0.5 - 35
//        for i in 0 ..< tabNameArray.count {
//            if i == 4 {
//                tabBtnWidth = 118
//            }else{
//                tabBtnWidth = 70
//            }
//            let tabBtn = UIButton.init(frame: CGRectMake(marginX, 0, tabBtnWidth, 25))
//            tabScrollView.addSubview(tabBtn)
//            tabBtn.setTitle(tabNameArray[i], forState: UIControlState.Normal)
//            tabBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            tabBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
//            tabSaveArray?.append(tabBtn)
////            tabBtn.addTarget(self, action: #selector(tabClickAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
////            btn.addTarget(self, action: #selector(HomeViewController.actionBtn), forControlEvents: UIControlEvents.TouchUpInside)
//
//            marginX += tabBtnWidth
//        }
//        tabScrollView.contentSize = CGSizeMake(marginX + 155, 50)
//        tabClickAction(tabSaveArray![0])
//        tabScrollView.scrollEnabled = false
//        
//        let underLine = UIView.init(frame: CGRectMake((SCREEN_W - 53)/2,frame.size.height - 25, 53, 2))
//        addSubview(underLine)
//        underLine.backgroundColor = UIColor.whiteColor()
//        
//        self.leftSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipes(_:)))
//        self.addGestureRecognizer(self.leftSwipeGestureRecognizer!)
//        self.leftSwipeGestureRecognizer?.direction = .Left
//        
//        self.rightSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipes(_:)))
//        self.addGestureRecognizer(self.rightSwipeGestureRecognizer!)
//        self.rightSwipeGestureRecognizer?.direction = .Right
//}
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    //左右滑动手势切换
//    func handleSwipes(sender:UISwipeGestureRecognizer){
//        //self.tabScrollView?.scrollEnabled = true
//        if sender.direction == .Right {
//             }else{
//                currentIndex = 0
//            }
//        }
////        if sender.direction == .Left {
////            if currentIndex + 1 < (tabSaveArray?.count){
////                }
////            }else{
////                currentIndex = (tabSaveArray?.count)! - 1
////            }
//    }
//
//
//
//
//    //点击Tab按钮切换
//   func  tabClickAction(btn:UIButton) {
////        let index = tabSaveArray?.indexOf(btn)
//        if (tabCallBack != nil) {
//            tabCallBack!(index: index!)
//        }
////        currentIndex = index
////        
////
////        
////        let offSetPoint = CGPointMake((btn.frame.origin.x + btn.frame.size.width*0.5) - SCREEN_W*0.5, 0)
////        tabScrollView?.setContentOffset(offSetPoint, animated: true)
//}

