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
        
        poseImage.image = (UIImage(named: feedbackSession.pose.imageName) ?? UIImage()).withAlignmentRectInsets(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        poseDifficultyLabel.text = feedbackSession.pose.difficulty
        poseNameLabel.text = feedbackSession.pose.name
        
        let sessionKeys = Array(feedbackSession.scores.keys)
        sessionTimeLabel.text = String(format: "%.2f", sessionKeys.max() ?? 0) + "s"
        
        let sessionValues = Array(feedbackSession.scores.values)
        sessionAccuracyLabel.text = String(format: "%.0f", (feedbackSession.valuesAsPercentage(usingMaxDistance: 1.25).reduce(0, {$0 + $1}) / Float(sessionValues.count))) + "%"
    }

}
