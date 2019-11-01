//
//  PosesTableViewCell.swift
//  Nolan
//
//  Created by Eduarda Mello on 29/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class PosesTableViewCell: UITableViewCell {

    @IBOutlet weak var poseImage: UIImageView!
    @IBOutlet weak var poseLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    var sessionSelected = 0
    var poseSelected = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        poseImage.image = Singleton.shared.poses[sessionSelected].photo
        poseLabel.text = Singleton.shared.poses[sessionSelected].name
        levelLabel.text = Singleton.shared.poses[sessionSelected].difficulty
        
        if Singleton.shared.poses[sessionSelected].pose[poseSelected].favorite {
            buttonFavorite.backgroundColor = UIColor.gray
        }
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
