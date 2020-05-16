//
//  TrackDetailVC.swift
//  Star
//
//  Created by Jeffrey Umandap on 5/15/20.
//  Copyright © 2020 Jeffrey Umandap. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import UIColor_Hex_Swift

@available(iOS 12.0, *)
class TrackDetailVC: UIViewController {
    weak var starDelegate: StarViewControllerDelegate?
    
    let defaults = UserDefaults.standard
    
    var idArray = [Int]()

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackDescription: UITextView!
    
    @IBOutlet weak var modalButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    @IBOutlet var labelsCollection: [UILabel]!
    
    var track: Track?
    
    func initData(forTrack track: Track) {
        self.track = track
    }
    @IBAction func doneTap(_ sender: Any) {
        dismiss(animated: true) {
            self.starDelegate?.reloadTable()
        }
    }
    
    @IBAction func favoriteTap(_ sender: Any) {
        let trackId = track?.trackId
        
        if !(idArray.contains(trackId!)) {
            idArray.append(trackId!)
            defaults.set(idArray, forKey: Common.defaultsKey)
        } else {
            if let index = idArray.firstIndex(of: trackId!) {
                idArray.remove(at: index)
            }
            defaults.set(idArray, forKey: Common.defaultsKey)
        }
        reloadIdArray()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        trackImage.layer.cornerRadius = 8.0
        trackImage.clipsToBounds = true
        favoriteButton.layer.cornerRadius = 8.0
        favoriteButton.clipsToBounds = true
        
        reloadIdArray()
        Common.darkModeAction(self, labels: labelsCollection, views: [self.view,headerView], headerView: [headerView])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = track?.trackName
        trackDescription.text = track?.longDescription?.replacingOccurrences(of: "\r\n\t\t", with: "")
        
        Alamofire.request(track!.artworkUrl100!).responseImage { response in
            if let image = response.result.value {
                self.trackImage.image = image
            }
        }
    }
    
    func reloadIdArray() {
        idArray = defaults.array(forKey: Common.defaultsKey)  as? [Int] ?? [Int]()
    
        if idArray.contains(track!.trackId) {
            favoriteButton.setTitle(Common.removeFavoriteButtonLabel, for: .normal)
            favoriteButton.backgroundColor = UIColor(Common.removeFavoriteButtonColor)

        } else {
            favoriteButton.setTitle(Common.addFavoriteButtonLabel, for: .normal)
            favoriteButton.backgroundColor = UIColor(Common.addFavoriteButtonColor)
        }
    }

}
