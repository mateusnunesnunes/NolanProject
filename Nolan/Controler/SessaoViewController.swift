//
//  SessaoViewController.swift
//  Nolan
//
//  Created by Mateus Nunes on 25/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class SessaoViewController: UIViewController {
    
    
    var indice:Int!
    @IBOutlet weak var imagemSessao: UIImageView!
    @IBOutlet weak var lblTituloSessao: UILabel!
    @IBOutlet weak var lblDificuldade: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var lblNomeSessao: UILabel!
    @IBOutlet weak var lblTempoDuracao: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTituloSessao.text = Singleton.shared.poses[indice].name
        lblDificuldade.text = Singleton.shared.poses[indice].difficulty
        lblCategoria.text = Singleton.shared.poses[indice].category
        lblNomeSessao.text = "TYPE"
        lblTempoDuracao.text = Singleton.shared.poses[indice].length
        lblLength.text = "LENGTH"
    }
//    init(imagemSessao:UIImage,lblTituloSessao:String,lblDificuldade:String,lblCategoria:String,lblNomeSessao:String,lblTempoDuracao:String,lblLength:String) {
//
//        self.imagemSessao.image = imagemSessao
//        self.lblTituloSessao.text = lblTituloSessao
//        self.lblDificuldade.text = lblDificuldade
//        self.lblCategoria.text = lblCategoria
//        self.lblNomeSessao.text = lblNomeSessao
//        self.lblTempoDuracao.text = lblTempoDuracao
//        self.lblLength.text = lblLength
//
//    }
    
    
}
