//
//  NextViewController.swift
//  api_test
//
//  Created by 大野 佑太郎 on 2017/10/05.
//  Copyright © 2017年 大野 佑太郎. All rights reserved.
//

import UIKit
import Alamofire // Alamofireをimport
import SwiftyJSON // SwiftyJSONをimport

class NextViewController : UIViewController, UITextFieldDelegate {
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        textField.text = "こんにちは"
        textField.delegate = self
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
        self.view.addSubview(textField)
        
        
        // 送信ボタン
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(self.submit), for: .touchUpInside)
        submitButton.sizeToFit()
//        submitButton.center = self.view.center
        submitButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        self.view.addSubview(submitButton)
    }
    
    /*
     UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
     */
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    /*
     UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
     */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        
        return true
    }
    
    /*
     改行ボタンが押された際に呼ばれるデリゲートメソッド.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // POST送信
    func submit() {
        
        let postString = "name=\(textField.text!)"
//
//        var request = URLRequest(url: URL(string: "http://localhost/todos")!)
        
        Alamofire.request("http://localhost:8080/todos", method: .post, parameters: ["name": postString])
            .responseJSON { response in
                print(response)
                }
//        request.httpMethod = "POST"
//        request.httpBody = postString.data(using: .utf8)
//        
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {
//            (data, response, error) in
//            
//
//            
//            print("response: \(response!)")
//
//            let phpOutput = String(data: data!, encoding: .utf8)!
//            print("php output: \(phpOutput)")
//        })
//        task.resume()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
