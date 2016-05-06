//
//  ViewController.swift
//  FTAlertView
//
//  Created by FarTeen on 5/1/16.
//  Copyright © 2016 FarTeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 5.0)), dispatch_get_main_queue()) {
            let action = FTAlertAction()
            action.action = {
                print("1")
            }
            action.style = .Default
            action.title = "确定"
            
            let action2 = FTAlertAction()
            action2.action = {
                print("2")
            }
            action2.style = .Cancel
            action2.title = "取消"
            
            let alertModel = FTAlertViewModel()
            alertModel.add("这是title", message: "这是message")
            alertModel.addAction(action)
            alertModel.addAction(action2)
            alertModel.showInContainer(self)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

