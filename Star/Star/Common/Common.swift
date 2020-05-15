//
//  Common.swift
//  Star
//
//  Created by Jeffrey Umandap on 5/15/20.
//  Copyright © 2020 Jeffrey Umandap. All rights reserved.
//

import Foundation
import UIKit


@available(iOS 12.0, *)
public class Common: NSObject {
    
    static let cantConnectToInternet = "Unable to connect to the Internet."

    static func quickAlert(_ vc:UIViewController, mtitle:String, message:String, onDone: (()->())?){
        let alert = UIAlertController(title: mtitle, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            if let onDone = onDone{
                onDone()
            }
        }
        
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }

    
    static func messageBox(_ vc:UIViewController, messageTitle: String, messageAlert: String, messageBoxStyle: UIAlertController.Style, alertActionStyle: UIAlertAction.Style,
                    completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: messageTitle, message: messageAlert, preferredStyle: messageBoxStyle)

        let okAction = UIAlertAction(title: "Ok", style: alertActionStyle) { _ in
            completionHandler()
        }

        alert.addAction(okAction)

        vc.present(alert, animated: true, completion: nil)
    }
    
    static func darkModeAction(_ vc: UIViewController, labels:[UILabel], views:[UIView], headerView: [UIView]) {
        
        if vc.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            for label in labels {
                label.textColor = .white
            }
            for view in views {
                view.backgroundColor = .black
            }
            for header in headerView {
                header.backgroundColor = .gray
            }
        } else {
            // User Interface is Light
        }
        
    }
    
    
}


