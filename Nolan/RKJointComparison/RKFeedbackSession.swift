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
    
    func valuesAsPercentage(usingMaxDistance maxDistance: Float) -> [Float] {
        let keys: [Float] = Array(self.scores.keys).sorted()
        let values = keys.map( { Float(self.scores[$0]!) } ) // 0...infinito
        let cappedValues = values.flatMap( { $0 > maxDistance ? maxDistance : $0 } ) // 0...maxDistance
        let normalizedValues = cappedValues.map( { $0 * 100/maxDistance}) //0...100
        return normalizedValues.map( { 100 - $0 }) //0...100
    }
    
}
