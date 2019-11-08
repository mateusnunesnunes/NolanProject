////
////  OnboardingViewController.swift
////  Nolan
////
////  Created by Eduarda Mello on 07/11/19.
////  Copyright © 2019 Mateus Nunes. All rights reserved.
////
//
//import UIKit
//
//class OnboardingViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        navigationController?.hidesBarsOnSwipe = true
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough"){
//
//        }
//
//        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
//        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
//            present(walkthroughViewController, animated: true, completion: nil)
//        }
//
//    }
//
//
//}
