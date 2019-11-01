//
//  ViewARPoseViewController.swift
//  
//
//  Created by Enzo Maruffa Moreira on 31/10/19.
//

import UIKit
import ARKit
import RealityKit
import Combine

class ViewARPoseViewController: UIViewController, ARSessionDelegate {
    
    var pose: Pose?
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var medLabel: UILabel!
    
    
    // AR STUFF
    @IBOutlet weak var arView: ARView!
    
    // The 3D character to display.
    var character: BodyTrackedEntity?
    let characterOffset: SIMD3<Float> = [0.7, 0, 0] // Offset the character by one meter to the left
    let characterAnchor = AnchorEntity()
    var characterTree: RKJointTree?
    
    var timerUpdater: Timer?
    
    var poseTree: RKImmutableJointTree?
    
    var shouldUpdate = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("Creating poseTree with pose file as \(pose?.jsonFilename)")
        
        createPoseTree()
        
        // start AR stuff
        arView.session = ARSession()
        arView.session.delegate = self
        
        // If the iOS device doesn't support body tracking, raise a developer error for
        // this unhandled case.
        guard ARBodyTrackingConfiguration.isSupported else {
            fatalError("This feature is only supported on devices with an A12 chip")
        }

        // Run a body tracking configration.
        let configuration = ARBodyTrackingConfiguration()
        arView.session.run(configuration)
        
        arView.scene.addAnchor(characterAnchor)
        
        // Asynchronously load the 3D character.
        var cancellable: AnyCancellable? = nil
        cancellable = Entity.loadBodyTrackedAsync(named: "robot").sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: Unable to load model: \(error.localizedDescription)")
                }
                cancellable?.cancel()
        }, receiveValue: { (character: Entity) in
            if let character = character as? BodyTrackedEntity {
                // Scale the character to human size
                character.scale = [1.0, 1.0, 1.0]
                self.character = character
                cancellable?.cancel()
            } else {
                print("Error: Unable to load model as BodyTrackedEntity")
            }
        })
        
        // start timer
        timerUpdater = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            self.shouldUpdate = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timerUpdater?.invalidate()
        timerUpdater = nil
    }
    
    func createPoseTree() {
        if let pose = self.pose {
            let url = Bundle.main.url(forResource: pose.jsonFilename, withExtension: "")!
            do {
                let jsonData = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                let tree = try decoder.decode(RKImmutableJointTree.self, from: jsonData)
                
                self.poseTree = tree
                
                print("Tree created with success! Yay!")
            }
            catch {
                print(error)
            }
        }
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }

                // Update the position of the character anchor's position.
                let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3)
                characterAnchor.position = bodyPosition + characterOffset
                
                // Also copy over the rotation of the body anchor, because the skeleton's pose
                // in the world is relative to the body anchor's rotation.
                characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
       
                if let character = character, character.parent == nil {
                    // Attach the character to its anchor as soon as
                    // 1. the body anchor was detected and
                    // 2. the character was loaded.
                    characterAnchor.addChild(character)
                    
                    let jointModelTransforms = bodyAnchor.skeleton.jointModelTransforms.map( { Transform(matrix: $0) })
                    let jointNames = character.jointNames
                    
                    let joints = Array(zip(jointNames, jointModelTransforms))
                    characterTree = RKJointTree(from: joints, usingAbsoluteTranslation: true)
                }
                
                if shouldUpdate {
                    
                    if let characterTree = self.characterTree, let character = self.character {
                        let jointModelTransforms = bodyAnchor.skeleton.jointModelTransforms.map( { Transform(matrix: $0) })
                        let jointNames = character.jointNames
                        
                        let joints = Array(zip(jointNames, jointModelTransforms))
                        
                        characterTree.updateJoints(from: joints, usingAbsoluteTranslation: true)
                        
                        if let poseTree = self.poseTree {
                            
                            print("Updating labels")
                            
                            let (min, max, avg, med) = characterTree.score(to: poseTree, consideringJoints: Array(RKJointWeights.jointWeights.keys))
                            
                            print("New values are \(min), \(max), \(avg), \(med)")
                            
                            self.minLabel.text = "min: " + min.description
                            self.maxLabel.text = "max: " + max.description
                            self.avgLabel.text = "avg: " + avg.description
                            self.medLabel.text = "med: " + med.description
                        }

                        shouldUpdate = false
                    }
                }
                
            }
        }


}
