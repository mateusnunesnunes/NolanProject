//
//  HistoryEntryViewController.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 08/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit
import Charts

class HistoryEntryViewController: UIViewController {

    @IBOutlet weak var performanceChartWrapper: UIView!
    @IBOutlet weak var performanceChart: LineChartView!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var poseNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var poseInfoContainerView: UIView!
    
    @IBOutlet weak var poseImageView: UIImageView!
    
    var feedbackSession: RKFeedbackSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let feedbackSession = self.feedbackSession {
            
            // TODO: fazer isso do jeito certo
            //            poseImage.image =
            
            poseNameLabel.text = feedbackSession.pose.name
            difficultyLabel.text = feedbackSession.pose.difficulty
            typeLabel.text = feedbackSession.pose.types
            
            poseImageView.image = UIImage(named: feedbackSession.pose.imageName) ?? UIImage()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            dateLabel.text = dateFormatter.string(from: feedbackSession.date)
            
            poseInfoContainerView.cornerRadius = 8
            addLightShadow(view: poseInfoContainerView)
            
            performanceChartWrapper.cornerRadius = 8
            addLightShadow(view: performanceChartWrapper)
            
            createChart(feedbackSession)
            
        }
        
    }
    
    func addLightShadow(view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.25
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
           
           let keys: [Float] = Array(feedbackSession.scores.keys).sorted()
           let chartValues = feedbackSession.valuesAsPercentage(usingMaxDistance: 1.25)
           
           var chartDataEntries: [ChartDataEntry] = []
           for i in 0..<chartValues.count {
               chartDataEntries.append(ChartDataEntry(x: Double(keys[i]), y: Double(chartValues[i])))
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
