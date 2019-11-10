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
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var poseInfoContainerView: UIView!
    @IBOutlet weak var poseImage: UIImageView!
    
    var pose: Pose?
    
    override var shouldAutorotate: Bool {
        false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        nomeLabel.text = pose?.name ?? "No pose defined"
        difficultyLabel.text = pose?.difficulty ?? "Undefined"
        typeLabel.text = pose?.types ?? "Undefined"
        
        poseImage.image = UIImage(named: pose?.imageName ?? "")
        
        shadowView(v: poseInfoContainerView, blur: 4, y: 2, opacity: 0.25)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    // Coloca sombra na view
    func shadowView (v : UIView!, blur : CGFloat, y: CGFloat, opacity : Float) {
        v.layer.shadowOffset = CGSize(width: 0, height: y)
        v.layer.shadowRadius = blur
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = opacity
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
