//
//  MyViewController.swift
//  SwiftTest
//
//  Created by ihaveuKevin on 16/9/27.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITextFieldDelegate {
    var logIn = UITextField()
    var logInLable = UILabel()
    var myKeyLable = UILabel()
    var myKey = UITextField()
    var logInBtn = UIButton()
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let secondVC = LoginSucViewController()
        secondVC.initClosure(self.takeClosure)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGBA(255, G: 255, B: 255, A: 1)
        logInLable.frame = CGRectMake(20, 100, 50, 40)
        logInLable.text = "账号"
        self.view.addSubview(logInLable)
        
        
        logIn.frame = CGRectMake(CGRectGetMaxX(logInLable.frame)+5, 100, 200, 40)
        logIn.placeholder = "请输入您的账号"
        logIn.clearButtonMode=UITextFieldViewMode.UnlessEditing
        logIn.borderStyle = UITextBorderStyle.RoundedRect
        logIn.becomeFirstResponder()
        logIn.returnKeyType = UIReturnKeyType.Done
        logIn.delegate = self
        self.view.addSubview(logIn)
        
        myKeyLable.frame = CGRectMake(20, CGRectGetMaxY(logInLable.frame)+20, 50, 40)
        myKeyLable.text = "密码"
        self.view.addSubview(myKeyLable)
        
        myKey.frame = CGRectMake(CGRectGetMaxX(myKeyLable.frame)+5, CGRectGetMaxY(logInLable.frame)+20, 200, 40)
        myKey.placeholder = "请输入您的密码"
        myKey.clearButtonMode=UITextFieldViewMode.UnlessEditing//编辑后出现清除按钮
        myKey.borderStyle = UITextBorderStyle.RoundedRect
        myKey.returnKeyType = UIReturnKeyType.Done //键盘return按键的样式,表示输入完成
        self.view.addSubview(myKey)
        myKey.delegate = self
        
        logInBtn.frame = CGRectMake(SCREEN_W/2-30, CGRectGetMaxY(myKeyLable.frame)+50, 60, 35)
        logInBtn.backgroundColor = UIColor.orangeColor()
//        logInBtn.titleLabel?.font = UIFont.systemFontSize(14)
        logInBtn.layer.cornerRadius = 6.0
        logInBtn.setTitle("登  录", forState: UIControlState.Normal)
        logInBtn.addTarget(self, action: #selector(btnClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(logInBtn)

        // Do any additional setup after loading the view.
    }
    
    // MARK: 函数指针
    func takeClosure(string: String) -> Void {
        print("反向传值")

        //拿到返回的值
        logIn.text = string
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text)
        return true;
    }
    
    func  btnClick(){
        
        let secondVC:LoginSucViewController = LoginSucViewController()
        
        
        //将当前postMessage函数指针传到第二个界面，第二个界面的闭包拿到该函数指针后会进行回调该函数

        secondVC.initClosure(self.takeClosure)
        self.navigationController?.pushViewController(secondVC,animated:true)

        print(logIn.text)
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
