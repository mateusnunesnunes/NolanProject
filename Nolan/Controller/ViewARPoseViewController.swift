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
import Speech

class ViewARPoseViewController: UIViewController, ARSessionDelegate {
    
    var pose: Pose?
    
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var medLabel: UILabel!
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var manualControlsView: UIView!
    
    @IBOutlet weak var manualStartButton: UIButton!
    @IBOutlet weak var manualCancelButton: UIButton!
    
    // AR STUFF
    @IBOutlet weak var arView: ARView!
    
    // The 3D character to display.
    var character: BodyTrackedEntity?
    let characterOffset: SIMD3<Float> = [0.7, 0, 0] // Offset the character by one meter to the left
    let characterAnchor = AnchorEntity()
    var characterTree: RKJointTree?
    
    var timerUpdater: Timer?
    var timerFeedback: Timer?
    var timerSpeech: Timer?
    
    var poseTree: RKImmutableJointTree?
    
    // Control variables
    var shouldUpdate = true
    var shouldGiveFeedback = true
    var sessionRunning = false
    var bodyPlaced = false
    
    var sessionStopped = false
    
    // Feedback Sessions
    var currentTime: Float = 0
    var feedbackSession: RKFeedbackSession?
    
    // Speech recognizing
    var audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var allTranscribedText: String = ""
    
    // Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startView.cornerRadius = 8
        startView.layer.shadowOffset = CGSize(width: 0, height: 5)
        startView.layer.shadowRadius = 3
        startView.layer.shadowColor = UIColor.darkGray.cgColor
        startView.layer.shadowOpacity = 0.25
        
        manualStartButton.cornerRadius = 8
        manualStartButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        manualStartButton.layer.shadowRadius = 3
        manualStartButton.layer.shadowColor = UIColor.darkGray.cgColor
        manualStartButton.layer.shadowOpacity = 0.25
        
        manualCancelButton.cornerRadius = 8
        manualCancelButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        manualCancelButton.layer.shadowRadius = 3
        manualCancelButton.layer.shadowColor = UIColor.darkGray.cgColor
        manualCancelButton.layer.shadowOpacity = 0.25
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
        startView.alpha = 1
        manualControlsView.alpha = 0
        
        audioEngine = AVAudioEngine()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
            if self.bodyPlaced {
                self.currentTime += 0.1
            }
        }
        
        timerFeedback = Timer.scheduledTimer(withTimeInterval: 5.5, repeats: true) { (_) in
            self.shouldGiveFeedback = true
        }
        
        timerSpeech = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (_) in
//            print("Handling speech")
            self.handleSpeech()
        }
        
        if let pose = self.pose {
            feedbackSession = RKFeedbackSession(pose: pose)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
        arView.session.pause()
        arView.removeFromSuperview()
        arView = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timerUpdater?.invalidate()
        timerUpdater = nil
        
        timerFeedback?.invalidate()
        timerFeedback = nil
        
        timerSpeech?.invalidate()
        timerSpeech = nil
        
        shouldUpdate = true
        shouldGiveFeedback = true
        sessionRunning = false
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
        if sessionRunning {
            for anchor in anchors {
                guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
                
                let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3)
                characterAnchor.position = bodyPosition + characterOffset
                
                characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
                
                if let character = character, character.parent == nil {
                    
                    characterAnchor.addChild(character)
                    
                    bodyPlaced = true
                    
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
                            analyzeTrees(characterTree, poseTree)
                        }
                        
                        shouldUpdate = false
                    }
                }
            }
        }
    }
    
    func analyzeTrees(_ characterTree: RKJointTree, _ poseTree: RKImmutableJointTree) {
        //print("Updating labels")
        
        let (min, max, avg, med) = characterTree.score(to: poseTree, consideringJoints: RKFeedbackGenerator.shared.feedbackableJoints)
        
        feedbackSession?.scores[currentTime] = max
        
        if shouldGiveFeedback {
            shouldGiveFeedback = false
            
            let feedback = RKFeedbackGenerator.shared.generateFeedback(forTracked: characterTree, andPose: poseTree, consideringJoints: RKFeedbackGenerator.shared.feedbackableJoints, maxDistance: 0.2)
            
            if let feedbackString = feedback?.toPhrase() {
                TTSController.shared.say(text: feedbackString)
            } else {
                TTSController.shared.say(text: "You are doing great! Keep it up :)")
            }
        }
        
        self.minLabel.text = "min: " + min.description
        self.maxLabel.text = "max: " + max.description
        self.avgLabel.text = "avg: " + avg.description
        self.medLabel.text = "med: " + med.description
    }
    
    @IBAction func firstStartPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.75) {
            self.startView.alpha = 0
            self.manualControlsView.alpha = 1
        }
        
        self.allTranscribedText = ""
        self.recordAndRecognizeSpeech()
    }
    
    @IBAction func manualStartPressed(_ sender: Any) {
        if !sessionRunning {
            startSession()
        } else {
            stopSession()
        }
    }
    
    @IBAction func manualCancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else { return }
        if !myRecognizer.isAvailable { return }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                let justRecognized = result.bestTranscription.formattedString
                self.allTranscribedText = justRecognized.lowercased()
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func startSession() {
        self.sessionRunning = true
        manualStartButton.setTitle("Stop", for: .normal)
        manualStartButton.backgroundColor = manualCancelButton.backgroundColor
    }
    
    func stopSession() {
        self.allTranscribedText = ""
        self.sessionRunning = false
        self.audioEngine.stop()
        if !sessionStopped {
            self.performSegue(withIdentifier: "viewSaveFeedback", sender: self.feedbackSession)
        }
        
        self.sessionStopped = true
    }
    
    func handleSpeech() {
//        print(allTranscribedText)
        if self.allTranscribedText.contains("start")  && !sessionRunning {
            startSession()
        } else if self.allTranscribedText.contains("stop") && sessionRunning {
            stopSession()
        }
    }
    
    // O prepare é chamado  sempre que uma segue é executada
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSaveFeedback" {
            
            // Se for, checo se o destino da Segue é de fato uma ViewARPoseViewController e se consigo converter o dado recebido em uma Pose
            if let destination = segue.destination as? SaveFeedbackViewController {
                destination.feedbackSession = sender as? RKFeedbackSession
            } else{
                // Se deu errado, avisa
                print("Failed creating view controller")
            }
        }
    }
    
    
    
}
