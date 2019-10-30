//
//  Video.swift
//  Nolan
//
//  Created by Eduarda Mello on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class Video {
    var duration: Int
    var watched: Bool
    
    init(duration: Int, watched: Bool) {
        self.duration = duration
        self.watched = watched
    }
}
