//
//  SessaoViewController.swift
//  Nolan
//
//  Created by Mateus Nunes on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class SessaoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var indice:Int!
    
    @IBOutlet weak var imagemSessao: UIImageView!
    @IBOutlet weak var lblTituloSessao: UILabel!
    @IBOutlet weak var lblDificuldade: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var lblNomeSessao: UILabel!
    @IBOutlet weak var lblTempoDuracao: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playViewLayout: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 85.0
        updateInterface()
       
    }

    // chamar os itens do singleton para popular a tela
    func updateInterface() {
        
        // popular tela com infos da sessão
        imagemSessao.image = Singleton.shared.sessions[indice].photo
        lblTituloSessao.text = Singleton.shared.sessions[indice].name
        lblDificuldade.text = Singleton.shared.sessions[indice].difficulty
        lblCategoria.text = Singleton.shared.sessions[indice].category
        lblNomeSessao.text = "TYPE"
        lblTempoDuracao.text = Singleton.shared.sessions[indice].length
        lblLength.text = "LENGTH"
        
        shadorView(v: playViewLayout, blur: 4, y: 2, opacity: 25.0)
        
    }
    
    // Coloca sombra na view
    func shadorView (v : UIView!, blur : CGFloat, y: CGFloat, opacity : Float) {
    
        v.layer.shadowOffset = CGSize(width: 0, height: y)
        v.layer.shadowRadius = blur
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = opacity
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Singleton.shared.sessions[indice].pose.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionPose", for: indexPath) as! SessionPoseTableViewCell

        cell.levelLabel.text = Singleton.shared.sessions[indice].pose[indexPath.row].difficulty
        cell.poseLabel.text = Singleton.shared.sessions[indice].pose[indexPath.row].name
//        cell.poseImage.image = Singleton.shared.sessions[indexPath.row].pose[]
        
        if cell.bookmarkButton.isEnabled == true{
            
            
            
        } else{
            
            
            
        }
        
        return cell
    }
    
    
    // Segue stuff ===
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singletonIndex = indexPath.row
        self.performSegue(withIdentifier: "showPose", sender: Singleton.shared.sessions[indice].pose[singletonIndex])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPose" {
            if let destination = segue.destination as? PoseDescriptionViewController, let pose = sender as? Pose {
                
                print("POSE CLICKADA \(pose)")
                destination.pose = pose
                
            }
        }
    }
    
}
