//
//  NetworkAPI.swift
//  Star
//
//  Created by Jeffrey Umandap on 5/15/20.
//  Copyright © 2020 Jeffrey Umandap. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

@available(iOS 12.0, *)
class NetworkAPI: NSObject {

    static let apiURL = "https://itunes.apple.com/search"
    
    internal static func dataToJson(data:Data) -> JSON? {
        do {
            let json = try JSON(data: data)
            return json
        } catch {
            return nil
        }
    }
    
    static func getData(onSuccess:((_ result:[Track])->())?,  onFail:((_ message:String)->())?){
        
        let params  = [
            "term":     "star",
            "country":  "au",
            "media":    "movie"
        ]
        
        Alamofire.request(apiURL, method: .get, parameters: params, headers:nil).responseJSON { response in
            
            if let json = response.data {
                
                guard let data = self.dataToJson(data:json)  else {
                    onFail?(Common.cantConnectToInternet)
                    return
                }
                
                var result: [Track] = []
                if(!data["results"].isEmpty){
                    for (_ , subJson):(String, JSON) in data["results"] {
                        let track = Track(value: subJson)
                        result.append(track)
                    }
                }
                onSuccess?(result)
            }
            else{
                onFail?(Common.cantConnectToInternet)
            }
        }
    }
}
