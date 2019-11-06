//
//  ProfileViewController.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 06/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var settingsContainer: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var clockContainer: UIView!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var calendarImageView: UIImageView!
    @IBOutlet weak var calendarLabel: UILabel!
    
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var chartImageView: UIImageView!
    @IBOutlet weak var chartLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatButton(view: userImageView)
        formatButton(view: settingsContainer)
        formatButton(view: clockContainer)
        formatButton(view: calendarContainer)
        formatButton(view: chartContainer)

        // Do any additional setup after loading the view.
    }
    
    func formatButton(view: UIView) {
        view.cornerRadius = view.frame.width * 0.3
        addLightShadow(view: view)
    }
    
    func addLightShadow(view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
