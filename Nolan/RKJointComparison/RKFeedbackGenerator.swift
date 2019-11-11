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
    
    let feedbackableJoints = ["hips_joint", "left_upLeg_joint", "right_upLeg_joint", "spine_1_joint", "spine_4_joint", "spine_7_joint", "right_shoulder_1_joint", "left_shoulder_1_joint", "right_arm_joint", "left_arm_joint", "right_forearm_joint", "left_forearm_joint", "left_leg_joint", "right_leg_joint", "left_foot_joint",  "right_foot_joint", "right_hand_joint", "left_hand_joint", "neck_4_joint", "head_joint"]
    
    func generateFeedback(forTracked trackedTree: RKJointTree, andPose poseTree: RKImmutableJointTree, consideringJoints jointList: [String], maxDistance threshold: Float) -> RKFeedback? {
        
        for jointName in jointList {
            if let firstPosition = trackedTree.rootJoint?.findDescendantBy(name: jointName)?.absoluteTranslation,
                let secondPosition = poseTree.rootJoint?.findDescendantBy(name: jointName)?.absoluteTranslation {
                
                let deltaX = (secondPosition.x - firstPosition.x)
                let deltaY = (secondPosition.y - firstPosition.y)
                let deltaZ = (secondPosition.z - firstPosition.z)
                
                let distance = sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
                print("Scanning \(jointName)...")
                print("Distance is \(distance) while threshold is \(threshold)")
                
                if distance > threshold {
                    
                    let (direction, totalDifference) = findAppropriateDirection(forCurrentPosition: firstPosition, andShouldBe: secondPosition)
                    
                    print("Generating feedback for \(jointName)")
                    print("First position: \(firstPosition)")
                    print("Second position: \(secondPosition)")
                    print(direction, totalDifference)
                    
                    var finalJointName = jointName.replacingOccurrences(of: "_joint", with: "")
                    if finalJointName.contains("right") {
                        finalJointName = finalJointName.replacingOccurrences(of: "right", with: "left")
                    } else if finalJointName.contains("left") {
                        finalJointName = finalJointName.replacingOccurrences(of: "left", with: "right")
                    }
                    
                    for i in 0..<10 {
                        finalJointName = jointName.replacingOccurrences(of: i.description, with: "")
                    }
                    
                    return RKFeedback(jointName: finalJointName, difference: totalDifference, direction: direction)
                }
            }
        }
        
        return nil
        
    }
    
    func findAppropriateDirection(forCurrentPosition currentPosition: SIMD3<Float>, andShouldBe posePosition: SIMD3<Float>) -> (
        RKFeedbackDirection, Float) {
            
            let xDifference = posePosition[0] - currentPosition[0]
            let yDifference = posePosition[1] - currentPosition[1]
            let zDifference = posePosition[2] - currentPosition[2]
            
            print(xDifference, yDifference, zDifference)
            
            if abs(xDifference) >= abs(yDifference) && abs(xDifference) >= abs(zDifference) {
                let direction: RKFeedbackDirection = xDifference > 0 ? .left : .right
                return (direction, xDifference)
            } else if abs(yDifference) >= abs(xDifference) && abs(yDifference) >= abs(zDifference) {
                let direction: RKFeedbackDirection = yDifference > 0 ? .up : .down
                return (direction, yDifference)
            } else {
                let direction: RKFeedbackDirection = zDifference > 0 ? .backward : .forward
                return (direction, zDifference)
            }
            
    }
}
