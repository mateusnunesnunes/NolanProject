//
//  PoseDescriptionViewController.swift
//  Nolan
//
//  Created by Cristiano Correia on 30/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class PoseDescriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    
    var index: Int!
    var count = 0
    
    var pose: Pose?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //não sei o que é isso, comenta aí quem fez!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singletonIndex = indexPath.row
        self.performSegue(withIdentifier: "viewPose", sender: pose)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPose" {
            if let destination = segue.destination as? ViewARPoseViewController, let pose = sender as? Pose {
                
                destination.pose = pose
                
            }
        }
    }
    //não sei o que é isso, comenta aí quem fez!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pose?.steps.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PoseDEscription", for: indexPath) as! PoseDescriptionTableViewCell
        
        
        cell.lblStep.text = "STEP \(indexPath.row+1)"
        cell.lblStepDescription.text = self.pose?.steps[indexPath.row]
        
        
        
        
        
        return cell
    }
    

}
