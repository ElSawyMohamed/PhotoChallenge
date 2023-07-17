//
//  PhotoTableViewCell.swift
//  PhotosChallenge
//
//  Created by Mohamed El Sawy on 15/07/2023.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var singlePhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
