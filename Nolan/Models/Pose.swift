//
//  Pose.swift
//  Nolan
//
//  Created by Eduarda Mello on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class Pose {
    var name: String
    var difficulty: String
    var types: String
    var steps: [String]
//    var videoGif:
    var favorite: Bool
    
    init(name: String, difficulty: String, types: String, steps: [String], favorite: Bool) {
        self.name = name
        self.difficulty = difficulty
        self.types = types
        self.steps = steps
        self.favorite = favorite
    }
}
