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
    var segmentedControlOption: Int!
    
    let poses: [Session] = [Session(name: "Session 1", difficulty: "Hard", photo: UIImage(named: "image1")!, pose: [Pose(name: "Pose 1", difficulty: "Hard", types: "dont know", steps: ["first- ksdksa, second- jsjadbjam, third- jajsdjsa"], favorite: true), Pose(name: "Pose 2", difficulty: "Easy", types: "ajsndkasdas", steps: ["dknsaias", "ndaidsa", "jsdiasd"], favorite: false), Pose(name: "Pose 3", difficulty: "kdcsk", types: "jdnfsnfsdk", steps: ["sdknfsdkf", "sdnsnsj", "sdjknnasj"], favorite: false)])]
    
    private init(){}
    
    func requestForLocation(){
        
    }
    
}


