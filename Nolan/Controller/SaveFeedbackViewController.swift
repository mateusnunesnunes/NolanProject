//
//  SaveFeedbackViewController.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 05/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit

class SaveFeedbackViewController: UIViewController {
    
    var feedbackSession: RKFeedbackSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(feedbackSession)
        if let feedbackSession = self.feedbackSession {
            print(Array(feedbackSession.scores.keys).sorted())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
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
