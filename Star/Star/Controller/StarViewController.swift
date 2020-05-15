//
//  StarViewController.swift
//  Star
//
//  Created by Jeffrey Umandap on 5/15/20.
//  Copyright © 2020 Jeffrey Umandap. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import Device


protocol StarViewControllerDelegate: class {
    func reloadTable()
}

@available(iOS 12.0, *)
class StarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StarViewControllerDelegate {
    func reloadTable() {
        tableViewData.reloadData()
    }
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableViewData: UITableView!
    
    
    var tracks = [Track]()
    var idArray: [Int] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Device.isPhone() {
            return (self.view.frame.height * 0.10)
        }
        else if Device.isPad() {
            return (self.view.frame.height * 0.05)
        }
        else {
            return (self.view.frame.height * 0.10)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackCell
        let track = tracks[indexPath.row]
        cell.trackName.text = track.trackName
        cell.genre.text = track.primaryGenreName
        cell.price.text = "$\(track.trackPrice)"
        
        Alamofire.request(track.artworkUrl100!).responseImage { response in
            if let image = response.result.value {
                cell.trackImage.image = image
            }
        }
        
        let array = defaults.array(forKey: "SavedTrackIDs")  as? [Int] ?? [Int]()
    
        cell.starImage.layer.cornerRadius = 8.0
        cell.starImage.clipsToBounds = true
        cell.starImage.isHidden = array.contains(track.trackId) ? false : true
        
        Common.darkModeAction(self, labels: cell.labelsCollection, views: [cell.contentView], headerView: [])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "trackDetailVC") as? TrackDetailVC else { return }
        
        vc.initData(forTrack: tracks[indexPath.row])
        vc.modalPresentationStyle = .formSheet
        vc.starDelegate = self
        presentDetail(vc)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData.delegate = self
        tableViewData.dataSource = self
        
        NetworkAPI.getData(onSuccess: { (result) in
            self.tracks = result
            self.tableViewData.reloadData()
        }, onFail: { message in
            Common.quickAlert(self, mtitle: "Star", message: message) {
                //
            }
        })

        defaults.set(idArray, forKey: "SavedTrackIDs")

        Common.darkModeAction(self, labels: [], views: [self.view], headerView: [])
        tableViewData.reloadData()
    }
    
}

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
}
