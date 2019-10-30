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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//TESTE
    //TESTE
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
