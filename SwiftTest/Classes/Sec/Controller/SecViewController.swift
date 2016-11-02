//
//  SecViewController.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import SDWebImage
class SecViewController: UIViewController,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate {
    var image = UIImageView()
    var heardView = UIScrollView()
    var tabView:TabView?
    
    let tabNameArray = ["潘金莲","西门庆","武大郎","武松","沉鱼","落雁","嘿嘿嘿"]
    //顶部视图左右滑动手势
    var leftSwipeGestureRecognizer:UISwipeGestureRecognizer?
    var rightSwipeGestureRecognizer:UISwipeGestureRecognizer?
    var tableView = UITableView()
    var cellStr = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellStr = "潘金莲"
        self.view.backgroundColor = UIColor.whiteColor()
        image.frame = CGRectMake(100, 100, 200, 300)
        image.image = UIImage(named:"333.jpg")
        self.view.addSubview(image)
        
        
        self.tableView = UITableView(frame: CGRectMake(0, 64+30, SCREEN_W, SCREEN_H-64-30-49))
        self.tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerNib(UINib.init(nibName: "ThirdTableViewCell", bundle: nil), forCellReuseIdentifier: "thirdCell")

        
        heardView = UIScrollView.init(frame: CGRectMake(0, 64 , SCREEN_W, 30))
        heardView.backgroundColor = UIColor.whiteColor()
        heardView.delegate = self
        heardView.showsHorizontalScrollIndicator = false
        self.view.addSubview(heardView)
        let tabBtnWidth:CGFloat = 70
        var marginX:CGFloat = 1
            for i in 0 ..< tabNameArray.count {
        
                let tabBtn = UIButton(type: .System)
                tabBtn.frame = CGRectMake(marginX,0,tabBtnWidth , 28)
                tabBtn.setTitle(tabNameArray[i], forState: UIControlState.Normal)
                tabBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                tabBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
                tabBtn.backgroundColor = UIColor.lightGrayColor()
                tabBtn.tag = 100+i
                tabBtn.addTarget(self, action: #selector(tabClickAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                marginX += tabBtnWidth+30
                heardView.addSubview(tabBtn)
        
    }
        
        
        heardView.contentSize = CGSizeMake(marginX + 155, 50)
        heardView.scrollEnabled = false

        
//        self.leftSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipes(_:)))
//        self.addGestureRecognizer(self.leftSwipeGestureRecognizer!)
//        self.leftSwipeGestureRecognizer?.direction = .Left
//        
//        self.rightSwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipes(_:)))
//        self.addGestureRecognizer(self.rightSwipeGestureRecognizer!)
//        self.rightSwipeGestureRecognizer?.direction = .Right
        // Do any additional setup after loading the view.
    }
    
    //左右滑动手势切换
    func handleSwipes(sender:UISwipeGestureRecognizer){
        //self.tabScrollView?.scrollEnabled = true
    }

    
    
    //点击Tab按钮切换
    func tabClickAction(btn:UIButton) {
        print(btn.titleLabel?.text)
        cellStr = (btn.titleLabel?.text)!
        tableView.reloadData()
        let offSetPoint = CGPointMake((btn.frame.origin.x + btn.frame.size.width*0.5) - SCREEN_W*0.5, 0)
        heardView.setContentOffset(offSetPoint, animated: true)

        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.heardView.scrollEnabled = false
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ThirdTableViewCell = tableView.dequeueReusableCellWithIdentifier("thirdCell", forIndexPath: indexPath) as! ThirdTableViewCell
        
        cell.nameLable?.text = cellStr as String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }




}
