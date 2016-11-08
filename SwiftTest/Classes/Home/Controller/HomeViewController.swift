//
//  HomeViewController.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var arr = ["大花","二花","三花","么么哒","嘿嘿嘿","老王","老黑","老白","我的","你的","他的"];
    var tableView = UITableView()
    var heardView = UIScrollView()
    let tabNameArray = ["12","23","24","56","78","90","34"]
    
    // 顶部刷新
    var header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//        SVProgressHUD .show()
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//            dispatch_async(dispatch_get_main_queue(), {
//                SVProgressHUD.dismiss()
//            })
//        }


        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        heardView.scrollEnabled = false
        self.tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H))
        self.tableView.delegate = self
        tableView.dataSource = self
//        tableView.backgroundColor = RGBA(100, G: 140, B: 211, A: 1)

        self.view.addSubview(tableView)
        tableView.registerNib(UINib.init(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")
        
//        SVProgressHUD.setMinimumDismissTimeInterval(0.5)
//        
//        SVProgressHUD.showSuccessWithStatus("首页展示")
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            print("MJ:(下拉刷新)")
            self.tableView.mj_header.endRefreshing()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("MJ:(上拉加载)")
            self.tableView.mj_footer.endRefreshing()
        })
        
        
        tableView.mj_header.beginRefreshing()
        toUpView()
        
        
    }
    
    
    
    // 滑动到顶部
    func toUpView(){
        
        let btn :UIButton = UIButton(type: .System)
        
        btn.backgroundColor = RGBA(100, G: 120, B: 130, A: 1)
        //btn.setImage(UIImage(named: "touch"), forState: UIControlState.Normal)
        
        btn.setTitle("up", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(20)
        btn.frame = CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-100, 50, 50)
        self.view.addSubview(btn)
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(HomeViewController.actionBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func actionBtn(){
        
        //myTableView.scrollsToTop = true
        
        let index: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        
        tableView.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        
        print("状态栏点击")
        
        return true
    }
    
    
    func upRefresh()  {
        print("下啦刷新")
    }
    
    func downRefresh()  {
        print("上啦刷新")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath) as! MyTableViewCell
        
        cell.nameLable?.text = arr[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 1 {//ChartsViewController
            let secondVC:ChartsViewController = ChartsViewController()
//            secondVC.name = arr[indexPath.row]
            self.navigationController?.pushViewController(secondVC,animated:true)

        }else{
            let secondVC:HomeNextViewController = HomeNextViewController()
            secondVC.name = arr[indexPath.row]
            self.navigationController?.pushViewController(secondVC,animated:true)
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
