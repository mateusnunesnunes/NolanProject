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
    @IBOutlet weak var performanceChartWrapper: UIView!
    
    @IBOutlet weak var poseInfoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var poseImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let feedbackSession = self.feedbackSession {
            
            // TODO: fazer isso do jeito certo
//            poseImage.image =
            
            nameLabel.text = feedbackSession.pose.name
            dateLabel.text = feedbackSession.date.description
            
            poseInfoView.cornerRadius = 20
            addLightShadow(view: poseInfoView)
            
            performanceChartWrapper.cornerRadius = 20
            addLightShadow(view: performanceChartWrapper)
            
            saveButton.cornerRadius = 10
            addLightShadow(view: saveButton)
            
            discardButton.cornerRadius = 10
            addLightShadow(view: discardButton)
            
            createChart(feedbackSession)
            
        }
    }
    
    func addLightShadow(view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.85
    }
    
    func createChart(_ feedbackSession: RKFeedbackSession) {
        
        performanceChart.drawGridBackgroundEnabled = false
        performanceChart.backgroundColor = .white
        performanceChart.drawBordersEnabled = false
        
        let maxDistance = 1.1
        
        let keys: [Float] = Array(feedbackSession.scores.keys).sorted()
        let values = keys.map( { Double(feedbackSession.scores[$0]!) } ) // 0...infinito
        let cappedValues = values.map( { $0 > maxDistance ? maxDistance : $0 } ) // 0...0.75
        let normalizedValues = cappedValues.map( { $0 * 100/maxDistance}) //0...100
        let chartValues = normalizedValues.map( { 100 - $0 }) //0...100
        
        var chartDataEntries: [ChartDataEntry] = []
        for i in 0..<chartValues.count {
            chartDataEntries.append(ChartDataEntry(x: Double(keys[i]), y: chartValues[i]))
        }
//        let values = keys.map( { ChartDataEntry(x: Double($0), y: chartValues } )
        
        
        let performanceLine = LineChartDataSet(entries: chartDataEntries, label: "Performance")
        performanceLine.setColor(.red)
        
        performanceLine.drawCirclesEnabled = false
        performanceLine.mode = .cubicBezier
        
        let data = LineChartData()
        data.addDataSet(performanceLine)
        
        performanceChart.data = data
        
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
