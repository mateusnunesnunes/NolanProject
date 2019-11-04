//
//  RKFeedbackSession.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 04/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation

class RKFeedbackSession {
    
    let pose: Pose
    let date = Date()
    
    var scores: [Float : Float] = [:]
    
    internal init(pose: Pose) {
        self.pose = pose
    }
    
}
