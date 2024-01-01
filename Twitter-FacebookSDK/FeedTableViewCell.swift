//
//  FeedTableViewCell.swift
//  Twitter-FacebookSDK
//
//  Created by Terry Jason on 2024/1/1.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var girlImageView: UIImageView! {
        didSet {
            girlImageView.layer.cornerRadius = 25.0
            girlImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
