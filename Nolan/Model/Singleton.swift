//
//  Singleton.swift
//  Nolan
//
//  Created by Mateus Nunes on 22/10/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import Foundation
import UIKit

class Singleton {
    
    static let shared = Singleton()
    var segmentedControlOption = -1
    var data: [Session]!
    var firstLoad = true
    func loadDataTrainView(id:Int){
        switch id {
        case 0:
            print("Focus")
            data = sessions.filter({$0.category == "Focus"})
            
        case 1:
            print("Concentration")
             data = sessions.filter({$0.category == "Concentration"})
        case 2:
            print("Balance")
            data = sessions.filter({$0.category == "Balance"})
        default:
            return
        }
    }
    let sessions: [Session] = [
        Session(name: "Yang TaiChiChuan", difficulty: "Begginer", photo: UIImage(named: "image1")!, pose: [
            Pose(
                name: "YE-MA-FEN-ZONG",
                difficulty: "Easy",
                types: "Focus",
                steps: [
                "Dobrar levemente os joelhos e levantar os braços",
                "Dobrar os braços e esticar a palma das mãos",
                "Imagine-se acariciando a crina de um cavalo"
                ],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
                name: "BAI HE LIANG CHI",
                difficulty: "Easy",
                types: "Focus",
                steps: [
                "Flexionar os joelhos e se imaginar na mata",
                "Abrir e fechar seus braços, encostando uma mão na outra",
                "Repetir esse movimento delicadamente, imitando uma garça abrindo e fechando suas asas"],
                favorite: false,
                jsonFilename: ""
            ),
            Pose(
                name: "SHOU HUI PIPA",
                difficulty: "Easy",
                types: "Focus",
                steps: [
                    "Flexionar os joelhos e deixar as costas eretas",
                    "Respirar levemente e se imaginar em contato com a natureza",
                    "Se imaginar tocando harpa em um local bem silencioso"],
                favorite: false,
                jsonFilename: ""
            ),
            Pose(
                name: "DAO-NIAN-HOU",
                difficulty: "Easy",
                types: "Focus",
                steps: [
                "Dobrar levemente os joelhos e levantar os braços",
                "Repetir esses movimento calmamente",
                "Imagine-se empurrando e puxando um macaco"
                ],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
                name: "LAN QUE WEI",
                difficulty: "Easy",
                types: "Focus",
                steps: [
                "Respirar levemente, imaginando-se estar um um lugar deserto",
                "Imagine-se alisando a calda de um pardal",
                "Flexione os joelhos e os braços e repita"
                ],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
                name: "YUN SHOU",
                difficulty: "Easy",
                types: "Focus",
                steps: [
                "Respire calmamente, como se estivesse nas nuvens",
                "Siga as nuvens com suas mão, realizando movimentos delicados",
                "Realize movimentos laterais com calma e se imagine no meio das nuvens"
                ],
                favorite: true,
                jsonFilename: ""
            )
            ],
                category: "Focus",
                length: "5'"
        ),
        Session(name: "大自然", difficulty: "Expert", photo: UIImage(named: "image2")!, pose: [
            Pose(
                name: "Parting the Horse's Mane",
                difficulty: "Medium",
                types: "Concentration",
                steps: [
                "Concentre seu peso na perna direita",
                "Transpondo o peso da perna esquerda levemente",
                "Repita o processo até que seu peso esteja equilibrado"
                ],
                favorite: false,
                jsonFilename: ""
            ),
            Pose(
                name: "Part the Wild Horse's Mane (左右野马分鬃)",
                difficulty: "Hard",
                types: "Concentration",
                steps: [
                "Mantenha a mão direita na altura dos ombros",
                "Posicione a mão esquerda na altura da cintura",
                "Respire calmamente e tenha claro em sua mente o valor do contato com a natureza"],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
                name: "Gong Bu",
                difficulty: "Easy",
                types: "Concentration",
                steps: [
                    "Mantenha a mão direita não altura da testa",
                    "Posicione a mão esquerda no nivel da cintura ",
                    "Imagine seu corpo se alinhando de acordo com cada posição adotada"],
                favorite: false,
                jsonFilename: ""
            ),
            Pose(
                name: "左右摟膝拗步",
                difficulty: "Easy",
                types: "Concentration",
                steps: [
                "Mude seu peso para trás, leve sua mão direita junto",
                "Recue o corpo levemente e continue",
                "Continue a recuar à medida que a mão esquerda se move na frente do rosto, como se acenasse sobre o ombro direito."
                ],
                favorite: true,
                jsonFilename: ""
            )
            ],
                category: "Concentration",
                length: "5'"
        ),
        Session(name: "Pínghéng", difficulty: "Medium", photo: UIImage(named: "image3")!, pose: [
            Pose(
                name: "Zuo Xia Shi Duli",
                difficulty: "Medium",
                types: "Balance",
                steps: [
                "Imagine que sua perna esquerda está fixa, como um peso no chão",
                "Uma cobra a rastejar, esse movimento sua perna direita deve realizar",
                "Entre em sintonia com a mãe natureza"
                ],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
                name: "You Suo Yu Nu Chuan Suo",
                difficulty: "Medium",
                types: "Balance",
                steps: [
                "A pé esquerdo deve apontar para o céu, e a perna esticar-se",
                "Posicione a perna direita reflixonada em relação ao corpo",
                "Posicine o braço na frente da cabeça e realize movimentos suaves e calmos"],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
               name: "左右摟膝拗步",
                difficulty: "Easy",
                types: "Balance",
                steps: [
                "Mude seu peso para trás, leve sua mão direita junto",
                "Recue o corpo levemente e continue",
                "Continue a recuar à medida que a mão esquerda se move na frente do rosto, como se acenasse sobre o ombro direito."
                ],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
                name: "Shan Tong Bei",
                difficulty: "Medium",
                types: "Balance",
                steps: [
                "Traga sua mão direita a frente do seu corpo",
                "Vire seu corpo para a direira levemente e dê um passo a frente com seu pé esquerdo",
                "Coloque seu peso no pé esquerdo e repita o processo com o outro pé"
                ],
                favorite: true,
                jsonFilename: ""
            )
            ],
                category: "Balance",
                length: "5'"
        ),
        Session(name: "魂靈", difficulty: "Begginer", photo: UIImage(named: "image4")!, pose: [
            Pose(
                name: "Zhuan Shen Ban Lan Chui",
                difficulty: "Medium",
                types: "Focus",
                steps: [
                "Seu corpo deve seguir uma curva",
                "Com os pés juntos, seu tronco de move levemente de um lado para outro",
                "Seu braços abertos e flexionados, imagine que você é uma onda "
                ],
                
                favorite: false,
                jsonFilename: ""
            ),
            Pose(
                name: "Ru Feng Si Bi",
                difficulty: "Hard",
                types: "Focus",
                steps: [
                "O punho direito deve estar a frente do corpo",
                "A mão esquerda passa por baixo do punho direito ",
                "Cotovelos e ombros permanecem baixos e flexíveis, mantenha as pernas abertas, flexionadas, e fixas"],
                favorite: true,
                jsonFilename: ""
            ),
            Pose(
                name: "Hai Di Zhen",
                difficulty: "Medium",
                types: "Focus",
                steps: [
                    "Mantenha as duas mãos a frente do joelho",
                    "Curve as duas pernas, sendo que a esquerda estará na frente da outra",
                    "Imagine-se mergulhando em um mar profundo para procurar uma agulha"],
                favorite: false,
                jsonFilename: ""
            ),
           Pose(
               name: "Parting the Horse's Mane",
               difficulty: "Medium",
               types: "Focus",
               steps: [
               "Concentre seu peso na perna direita",
               "Transpondo o peso da perna esquerda levemente",
               "Repita o processo até que seu peso esteja equilibrado"
               ],
               favorite: false,
               jsonFilename: ""
           )
            ],
                category: "Focus",
                length: "5'"
        )
    ]
    private init(){}
    
    func requestForLocation(){
        
    }
    
}


