//
//  extentions.swift
//  SwiftCalenderDemo
//
//  Created by 羽田　健太郎 on 2015/02/21.
//  Copyright (c) 2015年 OneWorld Inc. All rights reserved.
//


extension Array {
    mutating func removeObject<U: Equatable>(object: U) -> Bool {
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    self.removeAtIndex(idx)
                    return true
                }
            }
        }
        return false
    }
}
public extension NSDate {
    
    public func yearInt()->Int{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.stringFromDate(self).toInt()!
    }

    public func dayInt()->Int{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(self).toInt()!
    }

    public func monthInt()->Int{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.stringFromDate(self).toInt()!
    }
    
    public func nextMonthInt()->Int{
        var res:Int = self.monthInt()+1
        if res == 13{
            res = 1
        }
        return res
    }

    public func previousMonthInt()->Int{
        var res:Int = self.monthInt()-1
        if res == 0{
            res = 12
        }
        return res
    }
    
    public func nextYearInt()->Int{
        var res:Int = self.yearInt()+1
        return res
    }
    
    public func previousYearInt()->Int{
        var res:Int = self.yearInt()-1
        return res
    }
    
    public func additionalDateWithCtn(ctn:Int)->NSDate{
        return self.dateByAddingTimeInterval(60 * 60 * 24 * NSTimeInterval(ctn))
    }

    public func additionalWeekWithCtn(ctn:Int)->NSDate{
        return self.dateByAddingTimeInterval(60 * 60 * 24 * NSTimeInterval(ctn) * 7)
    }
    
    public func additionalMonthWithCtn(ctn:Int)->NSDate{
        var calendar:NSCalendar = NSCalendar(identifier: NSGregorianCalendar)!
        calendar.timeZone = NSTimeZone.localTimeZone()
        
        var comps:NSDateComponents = NSDateComponents()
        comps.month = ctn
        return calendar.dateByAddingComponents(comps, toDate: self, options: nil)!
    }
    
    public class func nowHour()->NSDate{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:"
        var nowTime:String = dateFormatter.stringFromDate(NSDate())
        nowTime = nowTime+"00:00"
        return NSDate.dateFromISOString(nowTime)
    }
    
    public class func nowHourAfter1hour()->NSDate{
        var date = NSDate.nowHour()
        return date.dateByAddingTimeInterval(60 * 60)
    }

    public class func datetime(date: NSDate) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm:ss"
        return dateFormatter.stringFromDate(date)
    }
    public func day() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(self)
    }
    public class func year(date: NSDate) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.stringFromDate(date)
    }
    public class func min(date: NSDate) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm"
        return dateFormatter.stringFromDate(date)
    }
    public class func hour(date: NSDate) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.stringFromDate(date)
    }
    
    public class func dateFromISOString(string: String) -> NSDate {
        var dateFormatter = NSDateFormatter()
//        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        return dateFormatter.dateFromString(string)!
    }
    
    public func time()->String{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.stringFromDate(self)
    }
    
    public class func datetime_detail(date: NSDate) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm:ss.SSS"
        return dateFormatter.stringFromDate(date)
    }
    
    public func weekDay()->String{
        let weekdays: Array  = ["日", "月", "火", "水", "木", "金", "土"]
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let comps: NSDateComponents = calender.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit|NSCalendarUnit.WeekdayCalendarUnit, fromDate: self)
        return weekdays[comps.weekday - 1]
    }
    
    public class func now()->String
    {
        return NSDate.datetime_detail(NSDate())
    }
    
    public class func getTommorrow(date:NSDate)->NSDate{
        return date.dateByAddingTimeInterval(24 * 60 * 60)
    }
    
    
    // 日曜
    public func getFirstDayInWeek()->NSDate{
        
        var calendar:NSCalendar = NSCalendar(identifier: NSGregorianCalendar)!
        calendar.timeZone = NSTimeZone.localTimeZone()
        var oneDayAgoComponents:NSDateComponents = NSDateComponents()
        
        var subcomponent:NSDateComponents = calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: self)
        oneDayAgoComponents.day = 0 - (subcomponent.weekday - 1)
        
        var beginningOfWeek:NSDate = calendar.dateByAddingComponents(oneDayAgoComponents, toDate: self, options: nil)!
        return beginningOfWeek
    }

    // 土曜
    public func getLastDayInWeek()->NSDate{
        
        var calendar:NSCalendar = NSCalendar(identifier: NSGregorianCalendar)!
        calendar.timeZone = NSTimeZone.localTimeZone()
        var oneDayAgoComponents:NSDateComponents = NSDateComponents()
        
        var subcomponent:NSDateComponents = calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: self)
        oneDayAgoComponents.day = 7 - subcomponent.weekday
        
        var beginningOfWeek:NSDate = calendar.dateByAddingComponents(oneDayAgoComponents, toDate: self, options: nil)!
        return beginningOfWeek
    }
    
    public func getThisWeekDays()->[NSDate]{
        var res = [NSDate]()
        var tmpDate:NSDate = self.getFirstDayInWeek()
        for (var i = 0; i<7;i++){
            res.append(tmpDate)
            tmpDate = tmpDate._tommorow()
        }
        return res
    }
    
    public func getFirstDayOnMonth()->NSDate{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/"
        dateFormatter.locale = NSLocale.currentLocale()
        var firstDateStr:String = dateFormatter.stringFromDate(self)
        firstDateStr = firstDateStr+"01 00:00:00"
        return NSDate.dateFromISOString(firstDateStr)
    }
    
    public class func getThisWeekDates(date:NSDate)->[NSDate]{
        var first = date.getFirstDayInWeek()
        var weekDate = [NSDate]()
        var addDate = first
        for (var i = 0 ;i < 7;i++){
            weekDate.append(addDate)
            addDate = NSDate.getTommorrow(addDate)
        }
        return weekDate
    }
    
    public func getFirstTimeOnDate()->NSDate{
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        var str:NSString = dateFormatter.stringFromDate(self)
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        
        return dateFormatter.dateFromString(NSString(format: "%@ 00:00:00", str) as String)!
    }
    
    public func getLastTimeOnDate()->NSDate{
        return NSDate.tommorow(self.getFirstTimeOnDate())
    }
    
    public class func tommorow(date:NSDate)->NSDate{
        return date.dateByAddingTimeInterval(60 * 60 * 24)
    }
    
    public func _tommorow()->NSDate{
        return self.dateByAddingTimeInterval(60 * 60 * 24)
    }
    public func _yesterday()->NSDate{
        return self.dateByAddingTimeInterval(-60 * 60 * 24)
    }
    
    public func getNextWeekDate()->NSDate
    {
        return self.additionalDateWithCtn(7)
    }
    public func getPreviousWeekDate()->NSDate
    {
        return self.additionalDateWithCtn(-7)
    }
    
    func isInDateRange(startDate:NSDate, endDate:NSDate)->Bool{
        if startDate.getFirstTimeOnDate() <= self && endDate.getLastTimeOnDate() > self{
            return true
        }
        return false
    }

    func isInRange(startDate:NSDate, endDate:NSDate)->Bool{
        if startDate <= self && endDate > self{
            return true
        }
        return false
    }

    func isSameDay(date:NSDate)->Bool{
        return self.day() == date.day() && self.monthInt() == date.monthInt() && self.yearInt() == date.yearInt()
    }

    func getNextYearAndMonth () -> (year:Int,month:Int){
        var next_year:Int = self.yearInt()
        var next_month:Int = self.monthInt() + 1
        if next_month > 12 {
            next_month=1
            next_year++
        }
        return (next_year,next_month)
    }
    
    func getPrevYearAndMonth () -> (year:Int,month:Int){
        var prev_year:Int = self.yearInt()
        var prev_month:Int = self.monthInt() - 1
        if prev_month == 0 {
            prev_month = 12
            prev_year--
        }
        return (prev_year,prev_month)
    }
}

    
/**
NSDate を比較する為の演算子です。

:param: left  左辺 NSDate
:param: right 右辺 NSDate

:returns: 右辺より左辺が過去であるかどうか
*/
public func < (left : NSDate, right : NSDate) -> Bool {
return left.compare(right) == NSComparisonResult.OrderedAscending
}

/**
NSDate の等値性を確認する為の演算子です。

:param: left  左辺 NSDate
:param: right 右辺 NSDate

:returns: 右辺と左辺が同一時刻であるかどうか
*/
public func == (left : NSDate, right : NSDate) -> Bool {
return left.isEqualToDate(right)
}

/**
NSDate を Strideable プロトコルに準拠させる為の実装です。
*/
extension NSDate : Strideable {
    
    typealias Stride = NSTimeInterval
    
    /**
    指定の NSTimeInterval 秒進んだ NSDate を返します。
    
    :param: n 何秒進むか
    
    :returns: 指定秒進んだ NSDate
    */
    public func advancedBy(n: NSTimeInterval) -> Self {
        return self.dynamicType.init(timeInterval: n, sinceDate: self)
    }
    
    /**
    指定の NSDate がどのくらいの秒数離れているかを NSTimeInterval で返します。
    
    :param: other 指定の NSDate
    
    :returns: 何秒離れているかを示す NSTimeInterval
    */
    public func distanceTo(other: NSDate) -> NSTimeInterval {
        return other.timeIntervalSinceDate(self)
    }
}
