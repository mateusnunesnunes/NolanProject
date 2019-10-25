//
//  Session.swift
//  Nolan
//
//  Created by Eduarda Mello on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation
import UIKit

class Session {
    var name: String
    var difficulty: String
    var photo: UIImage
//    var video: Video
    var pose: [Pose]
    
    init(name: String, difficulty: String, photo: UIImage, pose: [Pose]) {
        self.name = name
        self.difficulty = difficulty
        self.photo = photo
//        self.video = video
        self.pose = pose
    }
}
