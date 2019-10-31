//
//  PoseDescriptionViewController.swift
//  Nolan
//
//  Created by Cristiano Correia on 30/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class PoseDescriptionViewController: UIViewController {
    
    var pose: Pose?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewPosePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "viewPose", sender: self.pose)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewPose" {
            if let destination = segue.destination as? ViewARPoseViewController, let pose = sender as? Pose {
                
                print("Setting viewARPose file as \(pose.jsonFilename) and name \(pose.name)")
                destination.pose = pose
                
            } else{
                print("Failed creating view OR sender")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
