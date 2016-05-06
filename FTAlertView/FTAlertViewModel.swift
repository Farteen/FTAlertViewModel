//
//  FTAlertViewModel.swift
//  FTAlertView
//
//  Created by FarTeen on 5/1/16.
//  Copyright © 2016 FarTeen. All rights reserved.
//

import UIKit

enum FTAlertStyle {
    case Default,Cancel
    @available(iOS 8.0, *)
    func convertToUIAlertActionStyle() -> UIAlertActionStyle {
        switch self {
        case .Default:
            return UIAlertActionStyle.Default
        case .Cancel:
            return UIAlertActionStyle.Cancel
        }
    }
}

class FTAlertAction {
    var action: dispatch_block_t!
    var title: String!
    var style: FTAlertStyle!
}

class FTAlertViewModel: NSObject, UIAlertViewDelegate {
    
    deinit {
        print("deinit")
    }
    
    /// UIAlertView or UIAlertController
    var alertView: AnyObject! = {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            return alertController
        } else {
            let alertView = UIAlertView()
            alertView
            return alertView;
        }
    }()
    
    /// actionModels
    var actionModels: [FTAlertAction] = []
    
    //MARK: Initialization
    override init(){
        
        super.init()
        if #available(iOS 8.0, *) {
            
        } else {
            self.currentAlertView().delegate = self
        }
    }
    
    func add(title: String, message: String) {
        if #available(iOS 8.0, *) {
            self.currentAlertController().title = title
            self.currentAlertController().message = message
        } else {
            self.currentAlertView().title = title
            self.currentAlertView().message = message
        }
    }
    
    func addAction(action: FTAlertAction) {
        if #available(iOS 8.0, *) {
            let alertAction = UIAlertAction(title: action.title, style: action.style.convertToUIAlertActionStyle(), handler: { (alert) in
                action.action()
            })
            self.currentAlertController().addAction(alertAction)
        } else {
            actionModels.append(action)
            self.currentAlertView().addButtonWithTitle(action.title)
        }
    }
    
    func showInContainer(container: UIViewController) {
        if #available(iOS 8.0, *) {
            container.presentViewController(self.currentAlertController(), animated: true, completion: { 
                
            })
        } else {
            self.currentAlertView().show()
        }
    }
    
    //MARK: Util Method
    @available(iOS 8.0, *)
    private func currentAlertController() -> UIAlertController {
        return self.alertView as! UIAlertController
    }
    
    private func currentAlertView() -> UIAlertView {
        return self.alertView as! UIAlertView
    }
    
    //MARK:UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        let action = actionModels[buttonIndex]
        action.action()
    }
}
