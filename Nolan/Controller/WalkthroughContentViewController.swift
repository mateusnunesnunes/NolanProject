//
//  WalkthroughContentViewController.swift
//  Nolan
//
//  Created by Eduarda Mello on 07/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    var index = 0
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentImageView.image = UIImage(named: imageFile)
        
    }
    


}
