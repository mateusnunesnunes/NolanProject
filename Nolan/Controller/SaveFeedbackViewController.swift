//
//  SaveFeedbackViewController.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 05/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit
import Charts
import HealthKit

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
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            dateLabel.text = dateFormatter.string(from: feedbackSession.date)
            
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
        
        performanceChart.leftYAxisRenderer.axis?.axisMaximum = 100
        performanceChart.leftYAxisRenderer.axis?.axisMinimum = 0
        performanceChart.leftYAxisRenderer.axis?.drawGridLinesEnabled = false
        performanceChart.leftYAxisRenderer.axis?.drawLabelsEnabled = true
        
        performanceChart.rightYAxisRenderer.axis?.enabled = false
        
        performanceChart.xAxisRenderer.axis?.drawLabelsEnabled = true
        performanceChart.xAxisRenderer.axis?.drawGridLinesEnabled = false
        performanceChart.xAxis.labelPosition = .bottom
        
        performanceChart.legend.enabled = false
        
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
        
        let performanceLine = LineChartDataSet(entries: chartDataEntries, label: "Performance")
        performanceLine.setColor(.red)
        
        performanceLine.drawCirclesEnabled = false
        performanceLine.mode = .cubicBezier
        performanceLine.drawValuesEnabled = false
        
        let data = LineChartData()
        data.addDataSet(performanceLine)
        
        performanceChart.data = data
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    func requestAuthorization(_ healthStore: HKHealthStore) {
        let mindfulnessType = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
        ])
        
        healthStore.requestAuthorization(toShare: mindfulnessType, read: []) { (success, error) -> Void in
            if !success  {
                print("Error: \(error)")
            }
        }
    }
    
    func saveSession(_ healthStore: HKHealthStore) {
        // alarmTime and endTime are NSDate objects
        if let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession), let feedbackSession = self.feedbackSession {
            
            // we create our new object we want to push in Health app
            
            let totalSessionTime = TimeInterval(Array(feedbackSession.scores.keys).max() ?? 0)
            let startDate = feedbackSession.date
            let mindfullSample = HKCategorySample(type:mindfulType, value: 0, start: startDate, end: startDate + totalSessionTime)
            
            // at the end, we save it
            healthStore.save(mindfullSample, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    print("Health error")
                }
                
                if success {
                    print("Data saved")
                }
                
            })
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        // TODO: Ask for health kit permission. If accepted, save mindful seconds there.
        
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            let healthStore = HKHealthStore()
            
            requestAuthorization(healthStore)
            
            saveSession(healthStore)
        }
        
        // TODO: Add into user sessions
        
        popToPose()
    }
    
    
    @IBAction func discardPressed(_ sender: Any) {
        popToPose()
    }
    
    func popToPose() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
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
