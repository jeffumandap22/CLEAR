//
//  TrackCell.swift
//  Star
//
//  Created by Jeffrey Umandap on 5/15/20.
//  Copyright © 2020 Jeffrey Umandap. All rights reserved.
//

import Foundation
import UIKit


class TrackCell: UITableViewCell {

    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    
    @IBOutlet var labelsCollection: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
