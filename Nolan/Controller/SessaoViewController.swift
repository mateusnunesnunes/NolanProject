//
//  SessaoViewController.swift
//  Nolan
//
//  Created by Mateus Nunes on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class SessaoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sessionIndex:Int!
    
    @IBOutlet weak var imagemSessao: UIImageView!
    @IBOutlet weak var lblTituloSessao: UILabel!
    @IBOutlet weak var lblDificuldade: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var lblNomeSessao: UILabel!
    @IBOutlet weak var lblTempoDuracao: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 85.0
       
    }

    // chamar os itens do singleton para popular a tela
    func updateInterface() {
        
        // popular tela com infos da sessão
        imagemSessao.image = Singleton.shared.sessions[sessionIndex].photo
        lblTituloSessao.text = Singleton.shared.sessions[sessionIndex].name
        lblDificuldade.text = Singleton.shared.sessions[sessionIndex].difficulty
        lblCategoria.text = Singleton.shared.sessions[sessionIndex].category
        lblNomeSessao.text = "TYPE"
        lblTempoDuracao.text = Singleton.shared.sessions[sessionIndex].length
        lblLength.text = "LENGTH"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let session = Singleton.shared.sessions[sessionIndex].pose.count
        
        return Singleton.shared.sessions[sessionIndex].pose.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionPose", for: indexPath) as! SessionPoseTableViewCell

        return cell
    }
    
    
    // Segue stuff ===
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poseIndex = indexPath.row
        self.performSegue(withIdentifier: "showPose", sender: Singleton.shared.sessions[sessionIndex].pose[poseIndex])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPose" {
            if let destination = segue.destination as? PoseDescriptionViewController, let pose = sender as? Pose {
                
                destination.pose = pose
                
                print("Setting PoseDescriptionView Pose as \(pose)")
            }
        }
    }
    
}
