//
//  LoginSucViewController.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/30.
//  Copyright © 2016年 Kevin. All rights reserved.
//



/*
 1.首先在要传值的页面 定义
 typealias TestBlock = (model: 要传数据的类型)->()
 2.生成
 var blo: TestBlock?
 3.在需要的地方调用
 self.blo?(model: 要传的数据)
 4.然后在被传值的页面
 创建传值页面，然后：
 testVC.blo = { (model) -> Void in
 获得了model
 }
 */

import UIKit
//定义类型别名,闭包的类型别名为postClosure
typealias postClosure = (string:String) -> Void

class LoginSucViewController: UIViewController {
    //声明一个MClosure闭包
    var MClosure:postClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGBA(180, G: 180, B: 180, A: 1)
        createBack()
    }
    //传入上个界面的takeClosure函数指针
    func initClosure(closure: postClosure?) {
        //将函数指针赋值给MClosure闭包，此闭包包含takeClosure的局部变量等引用
        MClosure = closure
    }
    
    func createBack() {
        let btn: UIButton! = UIButton(type: UIButtonType.Custom)
        btn.frame = CGRect(x: 100, y: 200, width: 80, height: 80)
        btn.backgroundColor = UIColor.blackColor()
        btn.setTitle("返回", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(goBack), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn)
    }
    
    func goBack() {
        if self.MClosure != nil {//判断是否为空
            //回调：闭包隐式调用takeClosure函数
            self.MClosure!(string: "嘿嘿嘿")
        }

        self.navigationController?.popViewControllerAnimated(true)
        
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
