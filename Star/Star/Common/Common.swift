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
    
    static let defaultsKey                  = "SavedTrackIDs"
    static let cantConnectToInternet        = "Unable to connect to the Internet."
    
    static let removeFavoriteButtonLabel    = "Remove To Favorites"
    static let addFavoriteButtonLabel       = "Add to favorites"
    static let removeFavoriteButtonColor    = "#ef403d"
    static let addFavoriteButtonColor       = "#51C358"

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
    
    static func darkModeAction(_ vc: UIViewController, labels:[UILabel], views:[UIView], headerView: [UIView]) {
        
        if vc.traitCollection.userInterfaceStyle == .dark {
            
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
            //
        }
        
    }
    
    
}


