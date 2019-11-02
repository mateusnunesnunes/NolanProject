//
//  RKFeedbackGenerator.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 01/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation

class RKFeedbackGenerator {
    
    static  let shared = RKFeedbackGenerator()
    
    private init() {}
    
    let feedbackableJoints = ["hips_joint", "left_upLeg_joint", "left_leg_joint", "left_foot_joint", "right_upLeg_joint", "right_leg_joint", "right_foot_joint", "spine_1_joint", "spine_4_joint", "spine_7_joint", "neck_4_joint", "head_joint", "right_shoulder_1_joint", "right_arm_joint", "right_forearm_joint", "right_hand_joint", "left_shoulder_1_joint", "left_arm_joint", "left_forearm_joint", "left_hand_joint"]
    
    func generateFeedback(forTracked trackedTree: RKJointTree, andPose poseTree: RKImmutableJointTree, consideringJoints jointList: [String]) {
        
        for jointName in jointList {
            if let firstPosition = trackedTree.rootJoint?.findDescendantBy(name: jointName)?.absoluteTranslation,
                let secondPosition = poseTree.rootJoint?.findDescendantBy(name: jointName)?.absoluteTranslation {
                
                let deltaX = (secondPosition.x - firstPosition.x)
                let deltaY = (secondPosition.y - firstPosition.y)
                let deltaZ = (secondPosition.z - firstPosition.z)
                
                let distance = sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
                
                if distance > 0.15 {
                    print("Generating feedback for \(jointName)")
                    let feedback = findAppropriateEnum(for: jointName, withCurrentPosition: firstPosition, andShouldBe: secondPosition)
                    
                    break
                }
            }
        }
        
    }
    
    func findAppropriateEnum(for jointName: String, withCurrentPosition currentPosition: SIMD3<Float>, andShouldBe posePosition: SIMD3<Float>) -> RKFeedback? {
        guard feedbackableJoints.contains(jointName) else {
            return nil
        }
        
        if jointName == "right_arm_joint" {
            
        }
        
        return nil
    }
}
