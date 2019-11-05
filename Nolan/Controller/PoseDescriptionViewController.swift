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
    
    var pose: Pose?
    
    override var shouldAutorotate: Bool {
        false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func viewPosePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "viewPose", sender: self.pose)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pose?.steps.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PoseDEscription", for: indexPath) as! PoseDescriptionTableViewCell
        
        cell.lblStep.text = "STEP \(indexPath.row+1)"
        cell.lblStepDescription.text = self.pose?.steps[indexPath.row]
        
        return cell
    }
    
    
    @IBAction func viewARPressed(_ sender: Any) {
        // Executamos a segue - criada no Storyboard - com o  nome de viewPose enviando junto, como dado, a pose atual
        self.performSegue(withIdentifier: "viewPose", sender: pose)
    }
    
    // O prepare é chamado  sempre que uma segue é executada
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Vejo se a segue sendo executada é a "viewPose"
        if segue.identifier == "viewPose" {
            // Se for, checo se o destino da Segue é de fato uma ViewARPoseViewController e se consigo converter o dado recebido em uma Pose
            if let destination = segue.destination as? ViewARPoseViewController, let pose = sender as? Pose {
                // Se deu tudo certo, printo e seto no destino a pose como sendo a pose recebida por essa função - ou seja, a da view atual
                print("Setting viewARPose file as \(pose.jsonFilename) and name \(pose.name)")
                destination.pose = pose
            } else{
                // Se deu errado, avisa
                print("Failed creating view OR sender")
            }
        }
    }

}
