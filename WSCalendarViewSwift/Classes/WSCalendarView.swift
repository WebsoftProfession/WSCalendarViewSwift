//
//  WSCalendarView.swift
//  Calendar
//
//  Created by Vimal on 30/01/23.
//

import UIKit

public enum WSCalendarStyle : Int {
    case popup = 0
    case inline = 1
}

public enum WSWeekDays: String {
    case MON = "Mon"
    case TUE = "Tue"
    case WED = "Wed"
    case THU = "Thu"
    case FRI = "Fri"
    case SAT = "Sat"
    case SUN = "Sun"
}

public enum CalendarMode: Int {
    case Month = 0
    case Year
    case MonthYear
}


public protocol WSCalendarViewDelegate: NSObjectProtocol {
    func didTap(_ lblView: WSLabel?, with selectedDate: Date?)
    func deactiveWSCalendar(with selectedDate: Date?)
    func setupEventForDate() -> [Date]?
}


public class WSCalendarView: UIView {
    
    @IBOutlet weak var barBtnYear: UIBarButtonItem!
    @IBOutlet weak var barBtnMonth: UIBarButtonItem!
    @IBOutlet weak var lblBarDate: UILabel!
    @IBOutlet weak var btnYearPrev: UIButton!
    @IBOutlet weak var btnMonthPrev: UIButton!
    @IBOutlet weak var btnMonthNext: UIButton!
    @IBOutlet weak var btnYearNext: UIButton!
    
    @IBOutlet weak var lblDate1: WSLabel!
    @IBOutlet weak var lblDate2: WSLabel!
    @IBOutlet weak var lblDate3: WSLabel!
    @IBOutlet weak var lblDate4: WSLabel!
    @IBOutlet weak var lblDate5: WSLabel!
    @IBOutlet weak var lblDate6: WSLabel!
    @IBOutlet weak var lblDate7: WSLabel!
    @IBOutlet weak var lblDate8: WSLabel!
    @IBOutlet weak var lblDate9: WSLabel!
    @IBOutlet weak var lblDate10: WSLabel!
    @IBOutlet weak var lblDate11: WSLabel!
    @IBOutlet weak var lblDate12: WSLabel!
    @IBOutlet weak var lblDate13: WSLabel!
    @IBOutlet weak var lblDate14: WSLabel!
    @IBOutlet weak var lblDate15: WSLabel!
    @IBOutlet weak var lblDate16: WSLabel!
    @IBOutlet weak var lblDate17: WSLabel!
    @IBOutlet weak var lblDate18: WSLabel!
    @IBOutlet weak var lblDate19: WSLabel!
    @IBOutlet weak var lblDate20: WSLabel!
    @IBOutlet weak var lblDate21: WSLabel!
    @IBOutlet weak var lblDate22: WSLabel!
    @IBOutlet weak var lblDate23: WSLabel!
    @IBOutlet weak var lblDate24: WSLabel!
    @IBOutlet weak var lblDate25: WSLabel!
    @IBOutlet weak var lblDate26: WSLabel!
    @IBOutlet weak var lblDate27: WSLabel!
    @IBOutlet weak var lblDate28: WSLabel!
    @IBOutlet weak var lblDate29: WSLabel!
    @IBOutlet weak var lblDate30: WSLabel!
    @IBOutlet weak var lblDate31: WSLabel!
    
    
    // New
    @IBOutlet weak var lblDate32: WSLabel!
    @IBOutlet weak var lblDate33: WSLabel!
    @IBOutlet weak var lblDate34: WSLabel!
    @IBOutlet weak var lblDate35: WSLabel!
    @IBOutlet weak var lblDate36: WSLabel!
    @IBOutlet weak var lblDate37: WSLabel!
    @IBOutlet weak var lblDate38: WSLabel!
    @IBOutlet weak public var navBarView: UIView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    @IBOutlet weak var lblWeekDate: WSLabel!
    @IBOutlet weak var weekContainerView: UIView!
    
    private var daysInMonth: [Date] = []
    private var completeDateArray: [Date] =  []
    private var dateLabelArray: [WSLabel] = []
    private var selectedDate: Date!
    
    private var previousDate: Date!
    
    
    var activeTextField: UITextField? = nil
    var activeLabel: WSLabel? = nil
    
    
    // Calendar Properties
    public var calendarStyle = WSCalendarStyle.inline
    public var isShowEvent = false
    public var dayColor: UIColor?
    public var selectedDayColor: UIColor?
    public var weekDayNameColor: UIColor?
    public var barDateColor: UIColor?
    public var todayBackgroundColor: UIColor?
    public var tappedDayBackgroundColor: UIColor?
    public var eventColor: UIColor?
    var isShowOnlyMonth: Bool = false
    public var barDateFormat: String = "dd MMMM yyyy"
    public var calendarMode: CalendarMode = .MonthYear
    
    
    public class func initCalendar() -> WSCalendarView {
        let bundle = Bundle(for: WSCalendarView.self)
        return (bundle.loadNibNamed("WSCalendarView", owner: self, options: nil)?.first as? WSCalendarView)!
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    func initializeMonthYear() {
    
        dateLabelArray = [lblDate1, lblDate2, lblDate3, lblDate4, lblDate5, lblDate6, lblDate7, lblDate8, lblDate9, lblDate10, lblDate11, lblDate12, lblDate13, lblDate14, lblDate15, lblDate16, lblDate17, lblDate18, lblDate19, lblDate20, lblDate21, lblDate22, lblDate23, lblDate24, lblDate25, lblDate26, lblDate27, lblDate28, lblDate29, lblDate30, lblDate31, lblDate32, lblDate33, lblDate34, lblDate35, lblDate36, lblDate37, lblDate38]
        
        let currentDate = Date()
        
        self.setDayColor(self.dayColor)
        self.setWeekDayColor(self.weekDayNameColor)
        self.setLabelCircle(currentDate)
        
        setupCalendarMode()
        
        for i in 0..<38 {
            
            let lbl = dateLabelArray[i]
            
            lbl.tag = i
            lbl.layer.cornerRadius = lbl.frame.size.width
            let tapG = UITapGestureRecognizer(target: self, action: #selector(lblTapped(_:)))
            lbl.addGestureRecognizer(tapG)
            
            selectedDate = Date()
            previousDate = Date()
            self.setDateLabel(selectedDate)
            self.setYear(selectedDate)
            numberOfYearsInCalendar()
            self.setMonthLabels(currentDate)
            
            
        }
        
        self.layoutIfNeeded()
    }
    
    func setupCalendarMode(){
        isShowOnlyMonth = false
        switch  self.calendarMode {
            case .Month: do {
                isShowOnlyMonth = true
                btnYearNext.isHidden = false
                btnYearPrev.isHidden = false
                btnMonthNext.isHidden = true
                btnMonthPrev.isHidden = true
            }
            case .Year: do {
                btnYearNext.isHidden = false
                btnYearPrev.isHidden = false
                btnMonthNext.isHidden = true
                btnMonthPrev.isHidden = true
            }
            case .MonthYear: do {
                btnYearNext.isHidden = false
                btnYearPrev.isHidden = false
                btnMonthNext.isHidden = false
                btnMonthPrev.isHidden = false
            }
        }
    }
    
    func removeLabelCircle(_ currentDate: Date) {
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "dd"
        for i in 0..<38 {
            
            let lbl = dateLabelArray[i]
            lbl.layer.cornerRadius = (lbl.frame.size.width) / 2
            lbl.layer.borderWidth = 2.0
            lbl.textColor = dayColor ?? .black
            var isSelectedDate = false
            var isTodayMonth = false
            if dateString(matching: lbl.linkedDate ?? Date(), toDate: selectedDate) {
                isSelectedDate = true
            }
            
            if dateString(matching: lbl.linkedDate ?? Date()) {
                isTodayMonth = true
            }
            
            if isSelectedDate {
                lbl.layer.borderColor = UIColor.clear.cgColor
                lbl.textColor = selectedDayColor ?? dayColor ?? .black
                if (tappedDayBackgroundColor != nil) {
                    lbl.backgroundColor = tappedDayBackgroundColor
                } else {
                    lbl.backgroundColor = UIColor.lightGray
                }
            }
            else{
                if isTodayMonth {
                    lbl.textColor = selectedDayColor ?? dayColor ?? .black
                    lbl.layer.borderColor = UIColor.clear.cgColor
                    if (todayBackgroundColor != nil) {
                        lbl.backgroundColor = todayBackgroundColor
                    } else {
                        lbl.backgroundColor = UIColor.lightGray
                    }
                    /*if lbl.text == str {
                        lbl.layer.borderColor = UIColor.clear.cgColor
                        if (todayBackgroundColor != nil) {
                            lbl.backgroundColor = todayBackgroundColor
                        } else {
                            lbl.backgroundColor = UIColor.lightGray
                        }
                    } else {
                        lbl.layer.borderColor = UIColor.clear.cgColor
                        lbl.backgroundColor = UIColor.clear
                    }*/
                }
                else {
                    lbl.layer.borderColor = UIColor.clear.cgColor
                    lbl.backgroundColor = UIColor.clear
                }
            }
            
            
            if isShowEvent {
                generateEvent(onView: lbl)
            }
        }
    }
    
    func generateEvent(onView dayView: WSLabel?) {
        
        dayView?.subviews.forEach { $0.removeFromSuperview() }
        
        if let eventArray = delegate?.setupEventForDate() {
            if eventArray.count > 0 {
                for k in 0..<eventArray.count {
                    if let linkedDate = dayView?.linkedDate {
                        if compare(linkedDate, with: eventArray[k]) {
                            let eventView = WSEventView(frame: CGRect(x: (dayView?.frame.size.width ?? 0) / 2-2, y: (dayView?.frame.size.height ?? 0) - 6, width: 4, height: 4))
                            eventView.setEventViewColor(eventColor ?? UIColor.red)
                            dayView?.addSubview(eventView)
                        }
                    }
                }
            }
        }
    }
    
    func setLabelCircle(_ currentDate: Date) {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "dd"
        let str = monthFormatter.string(from: currentDate)
        for i in 0..<31 {
            let lbl = dateLabelArray[i]
            if dateString(matching: currentDate) {
                if lbl.text == str {
                    lbl.layer.cornerRadius = (lbl.frame.size.width) / 2
                    if (todayBackgroundColor != nil) {
                        lbl.backgroundColor = todayBackgroundColor
                    } else {
                        lbl.backgroundColor = .lightGray
                    }
                }
            }
        }
    }
    
    func compare(_ fromDate: Date, with toDate: Date) -> Bool {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "dd MMMM yyyy"
        let currentDateStr = monthFormatter.string(from: fromDate)
        let labelDateStr = monthFormatter.string(from: toDate)
        
        if currentDateStr == labelDateStr {
            return true
        } else {
            return false
        }
    }
    
    func dateString(matching selectedLabelDate: Date, toDate: Date = Date()) -> Bool {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "dd MMMM yyyy"
        let currentDateStr = monthFormatter.string(from: toDate)
        
        let labelDateStr = monthFormatter.string(from: selectedLabelDate)
        
        if currentDateStr == labelDateStr {
            return true
        } else {
            return false
        }
        
    }
    
    func compareCurrentMonthYear(toDate: Date) -> Bool {
        let month1 = Calendar.current.dateComponents([.month, .year], from: toDate)
        let month2 = Calendar.current.dateComponents([.month, .year], from: selectedDate)
        
        if month1.month == month2.month && month1.year == month2.year {
            return true
        }
        return false
    }
    
    @objc func lblTapped(_ tap: UITapGestureRecognizer) {
        
        let lbl = tap.view as? WSLabel
        
        selectedDate = lbl?.linkedDate
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "dd MMMM YYYY"
        lblBarDate.text = monthFormatter.string(from: selectedDate)
        self.setDateLabel(selectedDate)
        
        removeLabelCircle(selectedDate)
        lbl?.layer.cornerRadius = (lbl?.frame.size.width ?? 0) / 2
        if (tappedDayBackgroundColor != nil) {
            lbl?.backgroundColor = tappedDayBackgroundColor
        } else {
            lbl?.backgroundColor = UIColor.white
        }
        
        activeLabel = lbl
        delegate?.didTap(lbl, with: lbl?.linkedDate)
        
    }
    
    func numberOfYearsInCalendar() {
        var calendarDate = Date()
        completeDateArray.append(calendarDate)
        for _ in 0..<365 {
            var dc = DateComponents()
            dc.month = 0
            dc.day = 1
            let datein = Calendar.current.date(byAdding: dc, to: calendarDate)
            if let datein = datein {
                calendarDate = datein
                completeDateArray.append(datein)
            }
        }
    }
    
    func setMonthLabels(_ date: Date) {
        daysInMonth.removeAll()
        var currentDate = date
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd"
        var currentDayValue: Int? = nil
        currentDayValue = Int(dateFormatter1.string(from: currentDate)) ?? 0
        var i = currentDayValue!
        while i > 1 {
            var dc = DateComponents()
            dc.day = -1
            let datein = Calendar.current.date(byAdding: dc, to: currentDate)
            currentDate = datein ?? Date()
            i -= 1
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        var dc = DateComponents()
        dc.month = 1
        let endDate = Calendar.current.date(byAdding: dc, to: currentDate)
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = "dd MMMM yyyy"
        var endDateString: String? = nil
        if let endDate = endDate {
            endDateString = endDateFormatter.string(from: endDate)
        }
        daysInMonth.append(currentDate)
        
        endDateFormatter.dateFormat = "EEE"
        let weekDay = endDateFormatter.string(from: currentDate)
        
        let startFrom = self.getWeekDayCount(weekDay: weekDay)
        
        for _ in 0..<30 {
            
            var dc = DateComponents()
            dc.day = 1
            let datein = Calendar.current.date(byAdding: dc, to: currentDate)
            currentDate = datein ?? Date()
            if let datein = datein {
                daysInMonth.append(datein)
            }
        }
        for i in 0..<38 {
            let lbl = dateLabelArray[i]
            lbl.isHidden = true
        }
        for i in 0..<daysInMonth.count {
            
            let lbl = dateLabelArray[i + startFrom]
            
            lbl.linkedDate = daysInMonth[i]
            lbl.isHidden = false
            var currentDateValue: String? = nil
            
            currentDateValue = dateFormatter.string(from: daysInMonth[i])
            
            let endDateFormatter = DateFormatter()
            endDateFormatter.dateFormat = "dd MMMM yyyy"
            var currentDateString: String? = nil
            
            currentDateString = endDateFormatter.string(from: daysInMonth[i])
            
            if endDateFormatter.string(from: daysInMonth[i]) == endDateFormatter.string(from: Date()) {
                print("This date belongs to current date")
            }
            
            if currentDateString == endDateString {
                print("done")
                lbl.isHidden = true
                removeLabelCircle(date)
                return
            }
            lbl.text = currentDateValue
            if i == (daysInMonth.count - 1) {
                removeLabelCircle(date)
            }
        }
    }
    
    func setDateLabel(_ date: Date) {
        let monthFormatter = DateFormatter()
//        monthFormatter.dateFormat = "MMMM YYYY"
        monthFormatter.dateFormat = self.barDateFormat
        if compareCurrentMonthYear(toDate: date) {
            monthFormatter.dateFormat = self.barDateFormat
            lblBarDate.text = monthFormatter.string(from: selectedDate)
        }
        else{
            lblBarDate.text = monthFormatter.string(from: date)
        }
    }
    
    func setYear(_ date: Date?) {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = self.barDateFormat
        if let date = date {
            lblBarDate.text = monthFormatter.string(from: date)
        }
    }
    
    func setMonth(_ month: String?, andYear year: String?) {
        barBtnMonth.title = month
        barBtnYear.title = year
    }
    
    
    
    @IBAction func monthNextClicked(_ sender: Any) {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        let currentDate = monthFormatter.date(from: barBtnMonth.title ?? "") ?? Date()
        var dateComponent = DateComponents()
        dateComponent.month = 1
        let datein = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        if let datein = datein {
            barBtnMonth.title = monthFormatter.string(from: datein)
        }
        self.setMonthLabels(datein ?? Date())
    }
    
    @IBAction func yearNextClicked(_ sender: Any) {
        
        var dateComponent = DateComponents()
        if isShowOnlyMonth {
            dateComponent.month = 1
        }
        else{
            dateComponent.year = 1
        }
        
        let datein = Calendar.current.date(byAdding: dateComponent, to: previousDate) ?? Date()
        previousDate = datein
        self.setDateLabel(datein)
        self.setMonthLabels(datein)
    }
    
    @IBAction func yearPrevClicked(_ sender: Any) {
        
        var dateComponent = DateComponents()
        if isShowOnlyMonth {
            dateComponent.month = -1
        }
        else{
            dateComponent.year = -1
        }
        let datein = Calendar.current.date(byAdding: dateComponent, to: previousDate) ?? Date()
        previousDate = datein
        self.setDateLabel(datein)
        self.setMonthLabels(datein)
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        var dateComponent = DateComponents()
        dateComponent.month = 1
        let datein = Calendar.current.date(byAdding: dateComponent, to: previousDate) ?? Date()
        previousDate = datein
        self.setDateLabel(datein)
        self.setMonthLabels(datein)
    }
    
    @IBAction func prevClicked(_ sender: Any) {
        var dateComponent = DateComponents()
        dateComponent.month = -1
        let datein = Calendar.current.date(byAdding: dateComponent, to: previousDate) ?? Date()
        previousDate = datein
        self.setDateLabel(datein)
        self.setMonthLabels(datein)
    }
    
    public func reloadCalendar() {
        setupCalendarMode()
        self.setMonthLabels(selectedDate)
    }
    
    public var delegate: WSCalendarViewDelegate?
    
    public func setupAppearance() {
        if calendarStyle == .popup {
            isHidden = true
            clipsToBounds = true
            layer.cornerRadius = 5.0
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 1.0
        } else {
            btnCancel.isHidden = true
            btnOK.isHidden = true
        }
        
        initializeMonthYear()
    }
    
    public func activeCalendar(_ view: UIView?) {
        if (view is UITextField) || (view is UITextView) {
            activeTextField = view as? UITextField
        }
        reloadCalendar()
        addLayerToPopup()
        showCalendar(in: view)
    }
    
    func deActiveCalendar() {
        rempveLayerFromPopup()
        let view: UIView? = nil
        hideCalendar(in: view)
    }
    
    
    func setDayColor(_ dayColor: UIColor?) {
        self.dayColor = dayColor
        for i in 0..<(dateLabelArray.count) {
            let lbl = dateLabelArray[i]
            lbl.textColor = dayColor ?? .black
        }
    }
    
    func setWeekDayColor(_ weekColor: UIColor?){
        self.weekDayNameColor = weekColor
        self.weekContainerView.subviews.forEach { view in
            if let label = view as? UILabel {
                label.textColor = weekDayNameColor ?? .lightGray
            }
        }
    }
    
    
    public func setBarDateColor(_ barDateColor: UIColor?) {
        self.barDateColor = barDateColor
        lblBarDate.textColor = barDateColor
    }
    
    
    func setTodayBackgroundColor(_ todayBackgroundColor: UIColor?) {
        self.todayBackgroundColor = todayBackgroundColor
    }
    
    func setTappedDayBackgroundColor(_ tappedDayBackgroundColor: UIColor?) {
        self.tappedDayBackgroundColor = tappedDayBackgroundColor
    }
    
    public func setBarTint(_ tint: UIColor?){
        self.navBarView.subviews.forEach { view in
            view.tintColor = tint ?? .white
            if let label = view as? UILabel {
                label.textColor = tint ?? .white
            }
        }
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        activeTextField?.text = ""
        endEditing(true)
        superview?.endEditing(true)
        deActiveCalendar()
    }
    
    @IBAction func okAciton(_ sender: Any) {
        endEditing(true)
        superview?.endEditing(true)
        deActiveCalendar()
        if activeLabel == nil {
            delegate?.deactiveWSCalendar(with: Date())
        } else {
            delegate?.deactiveWSCalendar(with: activeLabel?.linkedDate)
        }
        
    }
    
    @IBAction func closeAction(_ sender: Any) {
        endEditing(true)
        deActiveCalendar()
    }
    
    func showCalendar(in view: UIView?) {
        isHidden = true
        alpha = 0.1
        let mainScreenFrame = UIScreen.main.bounds
        frame = CGRect(x: 20, y: mainScreenFrame.size.width / 2, width: mainScreenFrame.size.width - 40, height: self.frame.size.height)
        isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: { [self] in
            frame = CGRect(x: 20, y: mainScreenFrame.size.width / 2, width: mainScreenFrame.size.width - 40, height: self.frame.size.height)
            alpha = 1.0
        }) { finished in
            UIView.animate(withDuration: 0.1, animations: {
            }) { finished in
                
            }
        }
        
    }
    func hideCalendar(in view: UIView?) {
        
        isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
        }) { finished in
        }
    }
    
    func addLayerToPopup() {
//        let screenSize: CGRect = UIScreen.main.bounds
        let layerView = UIView(frame: superview?.frame ?? .zero)
        layerView.tag = 2000
        layerView.backgroundColor = .black
        layerView.alpha = 0.5
        layerView.center = window?.center ?? .zero
        let tapG = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(_:)))
        layerView.addGestureRecognizer(tapG)
        superview?.addSubview(layerView)
        superview?.bringSubviewToFront(self)
        
    }
    
    func rempveLayerFromPopup() {
        var layerView = window?.viewWithTag(2000)
        layerView?.removeFromSuperview()
        layerView = nil
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer?) {
        endEditing(true)
        superview?.endEditing(true)
        deActiveCalendar()
    }
    
    func getWeekDayCount(weekDay: String) -> Int {
        switch weekDay {
        case WSWeekDays.SUN.rawValue:
            return 0
        case WSWeekDays.MON.rawValue:
            return 1
        case WSWeekDays.TUE.rawValue:
            return 2
        case WSWeekDays.WED.rawValue:
            return 3
        case WSWeekDays.THU.rawValue:
            return 4
        case WSWeekDays.FRI.rawValue:
            return 5
        case WSWeekDays.SAT.rawValue:
            return 6
        default:
            return 1
        }
    }
}


