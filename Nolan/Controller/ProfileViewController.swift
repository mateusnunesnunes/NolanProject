//
//  ProfileViewController.swift
//  Nolan
//
//  Created by Enzo Maruffa Moreira on 06/11/19.
//  Copyright © 2019 Mateus Nunes. All rights reserved.
//

import UIKit
import FSCalendar

class ProfileViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
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
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarViewContaner: UIView!
    
    var allPracticedDates: [String] = []
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "YYYY-MM-dd"
        
        formatButton(view: userImageView)
        formatButton(view: clockContainer)
        formatButton(view: calendarContainer)
        formatButton(view: chartContainer)
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.today = nil
        
        calendar.placeholderType = .none
        
        calendar.appearance.titleFont = UIFont(name: "Futura", size: 13)
        calendar.appearance.weekdayFont = UIFont(name: "Futura", size: 15)
        calendar.appearance.headerTitleFont = UIFont(name: "Futura", size: 15)
        
        shadowView(v: calendarViewContaner, blur: 4, y: 2, opacity: 25)
        calendarViewContaner.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let feedbacks = Singleton.shared.feedbacks
        
        let dates = feedbacks.map( { formatter.string(from: $0.date) } )
        allPracticedDates = Array(Set(dates))
        calendar.reloadData()
        
        let totalTimeSeconds = feedbacks.reduce(0, { $0 + (Array($1.scores.values).max() ?? 0) } )
        let totalMinutes = Int(ceil(totalTimeSeconds / 60))
        clockLabel.text = totalMinutes.description + "\nminute" +  (totalMinutes != 1 ? "s" : "")
        
        calendarLabel.text = allPracticedDates.count.description + "\nday" +  (allPracticedDates.count != 1 ? "s" : "")

        let totalFeedbackMark = feedbacks.reduce(0, { $0 + $1.valuesAsPercentage(usingMaxDistance: 1.5).reduce(0, {$0 + $1 } ) } )
        
        let totalFeedbackCount = feedbacks.reduce(0, { $0 + Array($1.scores.keys).count } )
        
        chartLabel.text = Int((totalFeedbackMark / Float(totalFeedbackCount == 0 ? 1 : totalFeedbackCount))).description + "%\naccuracy"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // Coloca sombra na view
    func shadowView (v : UIView!, blur : CGFloat, y: CGFloat, opacity : Float) {
        v.layer.shadowOffset = CGSize(width: 0, height: y)
        v.layer.shadowRadius = blur
        v.layer.shadowColor = UIColor.lightGray.cgColor
        v.layer.shadowOpacity = opacity
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
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance,  titleDefaultColorFor date: Date) -> UIColor? {
        if allPracticedDates.contains(formatter.string(from: date))
        {
            return .white
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if allPracticedDates.contains(formatter.string(from: date))
        {
            return UIColor(displayP3Red: 0, green: 174/255, blue: 166/255, alpha: 1)
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor(displayP3Red: 226/255, green: 117/255, blue: 113/255, alpha: 1)
    }

    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if allPracticedDates.contains(formatter.string(from: date)) {
            return true
        }
        return false
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.performSegue(withIdentifier: "viewHistory", sender: date)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewHistory" {
            if let destination = segue.destination as? HistoryViewController, let date = sender as? Date {
                destination.date = date
            } else {
                print("Failed creating view OR sender")
            }
        }
    }
    
    /*
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
