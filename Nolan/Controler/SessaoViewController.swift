//
//  SessaoViewController.swift
//  Nolan
//
//  Created by Mateus Nunes on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class SessaoViewController: UIViewController {
    
    var sessions = Singleton.shared.poses

    @IBOutlet weak var imagemSessao: UIImageView!
    @IBOutlet weak var lblTituloSessao: UILabel!
    @IBOutlet weak var lblDificuldade: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var lblNomeSessao: UILabel!
    @IBOutlet weak var lblTempoDuracao: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
