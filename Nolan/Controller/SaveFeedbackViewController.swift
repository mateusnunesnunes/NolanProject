//
//  SaveFeedbackViewController.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 05/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit
import Charts

class SaveFeedbackViewController: UIViewController {
    
    var feedbackSession: RKFeedbackSession?

    @IBOutlet weak var performanceChart: LineChartView!
    
    @IBOutlet weak var poseInfoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var poseImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    
    func createChart(_ feedbackSession: RKFeedbackSession) {
        let keys: [Float] = Array(feedbackSession.scores.keys).sorted()
        let values = keys.map( { ChartDataEntry(x: Double(feedbackSession.scores[$0]!), y: Double($0)) })
        
        
        let line1 = LineChartDataSet(entries: values, label: "Performance")
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        performanceChart.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let feedbackSession = self.feedbackSession {
            
            // TODO: fazer isso do jeito certo
//            poseImage.image =
            
            poseInfoView.cornerRadius = 20
            poseInfoView.layer.shadowOffset = CGSize(width: 0, height: 5)
            poseInfoView.layer.shadowRadius = 3
            poseInfoView.layer.shadowColor = UIColor.lightGray.cgColor
            poseInfoView.layer.shadowOpacity = 0.85
            
            nameLabel.text = feedbackSession.pose.name
            dateLabel.text = feedbackSession.date.description
            
            performanceChart.cornerRadius = 20
            performanceChart.layer.shadowOffset = CGSize(width: 0, height: 5)
            performanceChart.layer.shadowRadius = 3
            performanceChart.layer.shadowColor = UIColor.lightGray.cgColor
            performanceChart.layer.shadowOpacity = 0.85
            
            createChart(feedbackSession)
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

    @IBAction func savePressed(_ sender: Any) {
        // TODO: Ask for health kit permission. If accepted, save mindful seconds there.
        
        // TODO: Add into user favorites
        
        popToPose()
    }
    
    @IBAction func discardPressed(_ sender: Any) {
        popToPose()
    }
    
    func popToPose() {
        // TODO: Dar pop da navigation até a pose
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
