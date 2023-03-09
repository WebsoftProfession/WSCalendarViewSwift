//
//  ViewController.swift
//  WSCalendarViewSwift
//
//  Created by WebsoftProfession on 02/02/2023.
//  Copyright (c) 2023 WebsoftProfession. All rights reserved.
//

import UIKit
import WSCalendarViewSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var calendarView: WSCalendarView!
    var calendarViewPopup: WSCalendarView!
    
    var eventArray: [Date]? = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        calendarView = WSCalendarView.initCalendar()
        calendarView.delegate = self
        calendarView.frame = containerView.bounds
        containerView.addSubview(calendarView)
        calendarView.dayColor = UIColor.black
        calendarView.selectedDayColor = UIColor.white
        calendarView.weekDayNameColor = UIColor.lightGray
        calendarView.barDateColor = UIColor.red
        calendarView.todayBackgroundColor = UIColor.blue
        calendarView.tappedDayBackgroundColor = UIColor.black
        calendarView.calendarStyle = .inline
        calendarView.isShowEvent = true
//        calendarView.navBarView.backgroundColor = .purple
        calendarView.calendarMode = .MonthYear
        calendarView.barDateFormat = "MMMM YYYY"
        calendarView.setBarTint(.white)
        calendarView.setupAppearance()
//        calendarView.reloadCalendar()
        var lastDate: Date?
        var dateComponent = DateComponents()
        for _ in 0..<10 {

            if lastDate == nil {
                lastDate = Date()
            } else {
                dateComponent.day = 1
            }
            var datein: Date? = nil
            if lastDate != nil {
                datein = Calendar.current.date(byAdding: dateComponent, to: lastDate!)
            }
            lastDate = datein
            eventArray?.append(datein!)
        }
        
        calendarView.reloadCalendar()
        
        // Popup Style calendar
        calendarViewPopup = WSCalendarView.initCalendar()
        calendarViewPopup.delegate = self
        self.view.addSubview(calendarViewPopup)
        
        calendarViewPopup.dayColor = UIColor.black
        
        calendarViewPopup.selectedDayColor = UIColor.white
        calendarViewPopup.weekDayNameColor = UIColor.lightGray
        calendarViewPopup.barDateColor = UIColor.purple
        calendarViewPopup.todayBackgroundColor = UIColor.blue
        calendarViewPopup.tappedDayBackgroundColor = UIColor.black
        calendarViewPopup.calendarStyle = .popup
        calendarViewPopup.isShowEvent = false
        calendarViewPopup.setBarTint(.white)
        calendarViewPopup.setupAppearance()
        calendarViewPopup.reloadCalendar()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: WSCalendarViewDelegate {
    func deactiveWSCalendar(with selectedDate: Date?) {
        
    }
    
    func setupEventForDate() -> [Date]? {
        return eventArray
    }
    
    func didTap(_ lblView: WSLabel?, with selectedDate: Date?) {
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        calendarViewPopup.activeCalendar(textField)
        return true
    }
}
