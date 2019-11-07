//
//  HistoryTableViewCell.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 07/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var poseImage: UIImageView!
    @IBOutlet weak var poseDifficultyLabel: UILabel!
    @IBOutlet weak var poseNameLabel: UILabel!
    @IBOutlet weak var sessionTimeLabel: UILabel!
    @IBOutlet weak var sessionAccuracyLabel: UILabel!

    var feedbackSession: RKFeedbackSession?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(feedbackSession: RKFeedbackSession) {
        self.feedbackSession = feedbackSession
        
        poseImage.image = UIImage()
        poseDifficultyLabel.text = feedbackSession.pose.difficulty
        poseNameLabel.text = feedbackSession.pose.name
        
        let sessionKeys = Array(feedbackSession.scores.keys)
        sessionTimeLabel.text = sessionKeys.max()?.description ?? "" + "s"
        
        let sessionValues = Array(feedbackSession.scores.values)
        sessionAccuracyLabel.text = (sessionValues.reduce(0, {$0 + $1}) / Float(sessionValues.count)).description + "%"
    }

}
