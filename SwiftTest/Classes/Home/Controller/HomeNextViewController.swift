//
//  HomeNextViewController.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/30.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class HomeNextViewController: UIViewController,tabClickDelegate,UITableViewDataSource,UITableViewDelegate {
    
    var cyclePictureView: CyclePictureView!
    var dataArray: NSArray? = {
        let path = NSBundle.mainBundle().pathForResource("Image.plist", ofType: nil)!
        var array = NSArray(contentsOfFile: path)
        return array
    }()
    var imageURLArray: [String] = []
    var imageDetailArray: [String] = []

    
    
    var name: String?
    var closure:(()->())?
    var tabView:TabView?
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = RGBA(100, G: 100, B: 100, A: 1)
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabView = TabView.init(frame: CGRectMake(0, 70, SCREEN_W, 50), array: ["111111","22222","33333","44444","5555","66666"])
        self.tabView?.delegate = self
        self.view.addSubview(self.tabView!)
//        let lable = UILabel()
//        lable.textColor = UIColor.redColor()
//        lable.frame = CGRectMake(100, 100, 100, 100)
//        lable.text = name
//        self.view.addSubview(lable)
        
        
        self.tableView = UITableView(frame: CGRectMake(0, 120, SCREEN_W, SCREEN_H-170))
        self.tableView.delegate = self
        tableView.dataSource = self
        //        tableView.backgroundColor = RGBA(100, G: 140, B: 211, A: 1)
        
        self.view.addSubview(tableView)
        tableView.registerNib(UINib.init(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "mycell")

        
        for i in 0..<dataArray!.count {
            imageURLArray.append(dataArray![i]["image"] as! String)
//            imageDetailArray.append(dataArray![i]["title"] as! String)
        }
        
        let cyclePictureView = CyclePictureView(frame: CGRectMake(0, 100, self.view.frame.width, 200), imageURLArray: nil)
        cyclePictureView.backgroundColor = UIColor.redColor()
        cyclePictureView.imageURLArray = imageURLArray
//        cyclePictureView.imageDetailArray = imageDetailArray
        cyclePictureView.timeInterval = 3
        self.tableView.tableHeaderView = cyclePictureView

        
    }
    
    //设置头视图的View
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view=UIView()
//        view.backgroundColor=UIColor.whi()
//        let textF=UITextField(frame: CGRectMake(10, 5, 120, 20))
//        textF.text="测试"
//        view.addSubview(textF)
//        return view  
//    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath) as! MyTableViewCell
        
//        cell.nameLable?.text = arr[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let secondVC:HomeNextViewController = HomeNextViewController()
////        secondVC.name = arr[indexPath.row]
//        self.navigationController?.pushViewController(secondVC,animated:true)
    }

    
    func btnClick() {
        print("啊啊啊啊啊啊啊啊啊啊啊啊")
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     
     let table:UITableView = UITableView(frame: CGRect(x: 0, y:0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height), style:.Plain)
     
     
     
     
     
     let identifier = "cellID"
     var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
     
     if cell == nil {
     cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
     }
     //UITableViewCellStyle
     //Default、Value1、Value2、Subtitle
     
     cell!.backgroundColor = UIColor.blueColor()
     
     cell!.textLabel!.text = "haha"
     
     return cell!
     
     
     文／_sunday（简书作者）
     原文链接：http://www.jianshu.com/p/8f7aab7e2d15
     著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
     */
    
    /*
    1.Optional    可选项不能直接参与运算 需要对它进行强行解包 (解包标识符'!')(强行解包: 程序员向系统保证我的可选项一定有值 你去用吧) 但是强行解包 可能会导致程序崩溃
    let 或者var 常量或者变量名: 数据类型? = 值
    变量的的可选项 默认值为 nil
    常量的可选项没有默认值
    var a:Int? //= 5
    
    
    guard 对可选项进项判断
    
    guard 判断如果可选项有值的话 代码会直接往下执行 如果为nil的话 那么直接return
    
    let name: String? = "123"
    let age: Int? = 18
    
    guard let Oname = name, let Oage = age else{
    return
    }

    
    2.if判断语句
    
    if 条件语句
    Swift中的 () 可以省略 {}  不可以省略
    空格大法
    Swift中 没有OC中'非零即真'的概念  它只有 true false
    if a > 5 {
    print("a 大于 5")
    } else if a >= 8 {
    
    }else {
    
    }
    
    3. for循环
    
    
    0..<5 代表 [0,5)
    0...5 代表 [0,5]
    
    for i in 0...5 {
    print(i)
    }
    
    
    for var i = 0; i < 3; i++{
    println(i)
    }
    
    
    4. 闭包
    
    格式: 闭包名 = {(参数名:参数类型...)->返回值类型 in 代码逻辑}
    
    let closure =  {(a:Int,b:Int) ->Int in
    return a + b
    }
    let result = closure(8,8)
    print(result)
    
    
    5,定义字符串
    
    str = "123123"
    
    6,定义数组
    
    var arr1:[NSObject] = ["老王","老张","老李"]
    
    使用let 定义 不可变数组
    使用var 定义 可变数组
    
    数组遍历
    for name in arr1 {
    print(name)
    }
    
    7, 字典
    
    dic1 = ["name":"老王","title":"名字"]
    
    遍历字典
    for (k,v) in dic {
    print(k,v)
    }
    
    8.断言 assert
    
    除非age大于等于零才会继续运行,小于零就行false,打印的错误信息就是 "年龄不能小于0"
    
    let age = -3 
    assert(age >=0,"年龄不能小于0")

    9.函数中的可变参数
     可以对两个数字求和,也可以对多个数字求和,只需要写一个函数
     func sum(numbers:Int...) -> {
        var total: Int = 0
        for num in numbers {
            total += number
       }
        return total
     }
     
     //sum函数的定义通过再参数列表后面加...的方式类定义可变参数,调用这个函数的时候我们可以根据自己的需要穿入多个参数
     注意事项: 1,一个函数最对只能有一个可变参数
              2,可变参数必须位于参数列表最后
     sum(1,2,3,4)
    
    */
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
