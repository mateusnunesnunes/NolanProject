//
//  RKFeedback.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 01/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation

class RKFeedback {
    
    let jointName: String
    let difference: Float
    let direction: RKFeedbackDirection
    
    init(jointName: String, difference: Float, direction: RKFeedbackDirection) {
        self.jointName = jointName
        self.difference = difference
        self.direction = direction
    }
    
}
