//
//  PoseDescriptionTableViewCell.swift
//  Nolan
//
//  Created by Cristiano Correia on 03/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class PoseDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var lblStepDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
