//
//  ThirdViewController.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MJRefresh
class ThirdViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var page = NSInteger()
    var tableView = UITableView()
    var dataArr=[AddressModel]()
    // 顶部刷新
    var header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        reloadDDDD()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.page = 0
        self.view.backgroundColor = RGBA(100, G: 240, B: 211, A: 1)
        self.tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H))
        self.tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)

        tableView.registerNib(UINib.init(nibName: "ThirdTableViewCell", bundle: nil), forCellReuseIdentifier: "thirdCell")
        
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            print("MJ:(下拉刷新)")
            self.page = 0
            self.reloadDDDD()
            self.tableView.mj_header.endRefreshing()
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("MJ:(上拉加载)")
            self.page = self.page+1
            self.reloadDDDD()
            self.tableView.mj_footer.endRefreshing()
        })
        
        
        tableView.mj_header.beginRefreshing()
        // Do any additional setup after loading the view.
    }
    //AF数据请求
//    func reloadData()  {
//        let urlStr = "http://101.200.229.100:8080/ZHCS//houseKeeper/selectCompany.do?"
////        let parame = ["qweqwe":"qeqwe","asdas":"sdada"]
//
//        Networktools.sharedTools.request(MethodType.GET, urlString: urlStr, parameters: nil, success: { (response) in
//            print(response)
//
//
//            guard let res = response?["listItems"] as?[[String: AnyObject]] else {
//                print("返回数据为nil 或者 类型不匹配")
//                return
//            }
//            var dataArr:[AddressModel] = [AddressModel]()
//            
//            for dic in res {
//                let status = AddressModel(dict:dic)
//                
//                dataArr.append(status)
//            }
//
//        }) { (error) in
//            NSLog(error)
//        }
//
//        
//    }
    
    
    
//  
//    func reloadDDDDddddd(){
//        let urlStr = "http://101.200.229.100:8080/ZHCS//houseKeeper/selectCompany.do?"
////        NetTools.GetJSONDataWithUrl()
//
//    }
    
    
    func reloadDDDD(){
        
        let urlStr = "http://101.200.229.100:8080/ZHCS/houseKeeper/selectCompany.do?"

        SVProgressHUD .show()
        //设置超时
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 5
        Alamofire.request(.GET, urlStr,parameters: ["pageSize": "15","pageIndex":self.page]).responseJSON { (response) in
            switch response.result {
            case .Success:
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    dispatch_async(dispatch_get_main_queue(), {
                        SVProgressHUD.dismiss()
                    })
                }
                 print(response)

                //把得到的JSON数据转为字典
                if let j = response.result.value as? NSDictionary{
                    //获取字典里面的key为数组
                    let Items1 = j.valueForKey("info")as! NSDictionary
                    let Items = Items1.valueForKey("listItems")as! NSArray
                    if self.page == 0{
                        self.dataArr = []
                    }
                    for dic in Items {
                        let status = AddressModel(dict:dic as! [String : AnyObject])
                        self.dataArr.append(status)
                    }
                    //上啦刷新判断下一页是否还有数据
                    if Items.count == 0 {
                        SVProgressHUD.showInfoWithStatus("没有更多数据了")
                        self.page  = self.page - 1

                    }else{
                        SVProgressHUD.showSuccessWithStatus("数据加载成功")
                    }
                    self.tableView.reloadData()

                }
                SVProgressHUD.dismissWithDelay(1.0)
            case .Failure(let error):
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    dispatch_async(dispatch_get_main_queue(), {
                        SVProgressHUD.dismiss()
                    })
                }
                print(error)
            }
        }
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ThirdTableViewCell = tableView.dequeueReusableCellWithIdentifier("thirdCell", forIndexPath: indexPath) as! ThirdTableViewCell
        let AddressModel = self.dataArr[indexPath.row]
        
        cell.nameLable?.text = AddressModel.address
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
