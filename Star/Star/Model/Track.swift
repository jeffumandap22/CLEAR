//
//  Track.swift
//  Star
//
//  Created by Jeffrey Umandap on 5/15/20.
//  Copyright © 2020 Jeffrey Umandap. All rights reserved.
//

import Foundation
import SwiftyJSON

class Track: NSObject {
    
    var trackName: String?
    var artworkUrl100: String?
    var primaryGenreName: String?
    var trackPrice: Double = 0.00
    var longDescription : String?
    var trackId: Int = 0
    
    public override init() { }
    
    convenience init(value:JSON) {
        self.init()
        self.trackName          = value["trackName"].string ?? ""
        self.artworkUrl100      = value["artworkUrl100"].string ?? ""
        self.primaryGenreName   = value["primaryGenreName"].string ?? ""
        self.trackPrice         = value["trackPrice"].double ?? 0.0
        self.longDescription    = value["longDescription"].string ?? ""
        self.trackId            = value["trackId"].int ?? 0
    }
    
}
