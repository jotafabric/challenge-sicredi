//
//  EventListTableViewCell.swift
//  ChallengeSicredi
//
//  Created by Josias Fabrício on 13/12/21.
//

import Foundation
import UIKit
import Kingfisher

class EventListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var event: Event? {
        didSet{
            titleLabel.text = event?.title
            dateLabel.text = event?.date?.intToDateTime?.dateAndTimetoString()
            priceLabel.text = event?.price?.currencyValue
            
            img.kf.setImage(with: URL(string: event!.image!), placeholder: UIImage(named: "eventImageDefault"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
}


