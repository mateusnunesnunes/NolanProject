//
//  User.swift
//  Nolan
//
//  Created by Eduarda Mello on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation
import UIKit

class User {
    var name: String
    var photo: UIImage
    var timePracticed: Time
    var sessionList: [Session]
    var correctPose: Int
    var favoritePoses: [Pose]
    
    init(name: String, photo: UIImage, timePracticed: Time, sessionList: [Session], correctPose: Int, favoritePoses: [Pose]) {
        self.name = name
        self.photo = photo
        self.timePracticed = timePracticed
        self.sessionList = sessionList
        self.correctPose = correctPose
        self.favoritePoses = favoritePoses
    }
    
}
