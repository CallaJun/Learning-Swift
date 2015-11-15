import UIKit

// Bryn Mawr to Haverford
var leaveBmc: [NSDate] = []
var arriveHc: [NSDate] = []

// Haverford to Bryn Mawr
var leaveHc: [NSDate] = []
var arriveBmc: [NSDate] = []

var currentDate = NSDate()

// Populate global variables with schedules, with correct times based on weekday
func populateScheduleArrays() {
    let calendar = NSCalendar.currentCalendar()
    let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Weekday, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: currentDate)
    
    let convertToToday: String = "\(dateComponents.month)-\(dateComponents.day)-\(dateComponents.year) "
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
    
    // Bryn Mawr to Haverford
    let toLeaveBmc: [String] = [
        // Sunday 0-19
        "01:00", "02:00", "02:45", "09:30", "10:15", "11:30", "12:30", "13:30", "14:30", "15:30", "17:00", "17:30", "18:00", "18:30", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00",
        // Monday 20-53
        "07:25", "08:10", "09:10", "09:20", "10:00", "10:10", "11:30", "11:40", "12:00", "12:10", "12:30", "13:30", "14:30", "12:40", "13:00", "13:10", "13:30", "13:40", "14:00", "14:10", "14:35", "15:10", "15:20", "15:45", "15:55", "16:15", "17:10", "18:10", "18:40", "19:10", "20:10", "21:10", "22:20", "23:10",
        // Tuesday 54-85
        "24:10", "07:10", "08:10", "08:55", "09:05", "09:45", "09:55", "10:25", "10:35", "11:10", "11:20", "11:55", "12:05", "12:45", "12:50", "13:25", "13:35", "14:10", "14:25", "15:10", "15:20", "15:45", "15:55", "16:15", "17:10", "18:10", "18:40", "19:10", "20:10", "21:10", "22:20", "23:10",
        // Wednesday 86-122
        "24:10", "07:25", "08:10", "09:10", "09:20", "10:00", "10:10", "10:30", "10:40", "11:00", "11:10", "11:30", "11:40", "12:00", "12:10", "12:30", "12:40", "13:00", "13:10", "13:30", "13:40", "14:00", "14:10", "14:35", "15:10", "15:20", "15:45", "15:55", "16:15", "17:10", "18:10", "18:40", "19:10", "20:10", "21:10", "22:20", "23:10",
        // Thursday 123-155
        "24:10", "07:10", "08:10", "08:55", "09:05", "09:45", "09:55", "10:25", "10:35", "11:10", "11:20", "11:55", "12:05", "12:40", "12:50", "13:25", "13:35", "14:10", "14:25", "15:10", "15:20", "15:45", "15:55", "16:15", "17:10", "18:10", "18:40", "19:10", "20:10", "21:10", "21:50", "22:20", "23:10",
        // Friday 156-185
        "24:10", "07:25", "08:10", "09:10", "09:20", "10:00", "10:10", "10:30", "10:40", "11:00", "11:10", "11:30", "11:40", "12:00", "12:30", "13:10", "13:35", "14:00", "14:35", "15:10", "15:45", "16:15", "17:10", "18:10", "18:40", "19:10", "20:10", "21:10", "22:20", "23:10",
        // Saturday 186
        "24:10", "01:10", "02:00", "11:15", "12:15", "13:15", "14:15", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "21:00", "22:00", "22:30", "23:00", "24:00", "24:30"
    ]
    let toArriveHc: [String] = [
        // Sunday
        "01:10", "02:10", "02:55", "09:40", "10:25", "11:40", "12:40", "13:40", "14:40", "15:40", "17:10", "17:40", "18:10", "18:40", "19:10", "20:10", "21:10", "22:10", "23:10", "24:10",
        // Monday
        "07:35", "08:20", "09:20", "09:30", "10:10", "10:20", "11:40", "11:50", "12:10", "12:20", "12:40", "13:40", "14:40", "12:50", "13:10", "13:20", "13:40", "13:50", "14:10", "14:20", "14:45", "15:20", "15:30", "15:55", "16:05", "16:25", "17:20", "18:20", "18:50", "19:20", "20:20", "21:20", "22:30", "23:20",
        // Tuesday
        "24:20", "07:20", "08:20", "09:05", "09:15", "09:55", "10:05", "10:35", "10:45", "11:20", "11:30", "12:05", "12:15", "12:55", "13:00", "13:35", "13:45", "14:20", "14:35", "15:20", "15:30", "15:55", "16:05", "16:25", "17:20", "18:20", "18:50", "19:20", "20:20", "21:20", "22:30", "23:20",
        // Wednesday
        "24:20", "07:35", "08:20", "09:20", "09:30", "10:10", "10:20", "10:40", "10:50", "11:10", "11:20", "11:40", "11:50", "12:10", "12:20", "12:40", "12:50", "13:10", "13:20", "13:40", "13:50", "14:10", "14:20", "14:45", "15:20", "15:30", "15:55", "16:05", "16:25", "17:20", "18:20", "18:50", "19:20", "20:20", "21:20", "22:30", "23:20",
        // Thursday
        "24:20", "07:20", "08:20", "09:05", "09:15", "09:55", "10:05", "10:35", "10:45", "11:20", "11:30", "12:05", "12:15", "12:50", "13:00", "13:35", "13:45", "14:20",  "14:35", "15:20", "15:30", "15:55", "16:05", "16:25", "17:20", "18:20", "18:50", "19:20", "20:20", "21:20", "22:00", "22:30", "23:20",
        // Friday
        "24:20", "07:35", "08:20", "09:20", "09:30", "10:10", "10:20", "10:40", "10:50", "11:10", "11:20", "11:40", "11:50", "12:10", "12:40", "13:20", "13:45", "14:10", "14:45", "15:20", "15:55", "16:25", "17:20", "18:20", "18:50", "19:20", "20:20", "21:20", "22:30", "23:20",
        // Saturday
         "24:20", "01:20", "02:10", "11:35", "12:35", "13:35", "14:35", "17:10", "17:40", "18:10", "18:40", "19:10", "19:40", "20:10", "21:10", "22:10", "22:40", "23:10", "24:10", "24:40"
    ]
    
    // Haverford to Bryn Mawr
    let toLeaveHc: [String] = [
        // Sunday
        "09:45", "10:45", "11:45", "12:45", "13:45", "14:45", "15:45", "17:15",
        "17:45", "18:15", "18:45", "19:15", "20:15", "21:15", "22:15", "23:15",
        // Monday
        "24:15", "07:40", "08:40", "08:50", "09:40", "09:50", "10:15", "10:25", "10:40", "10:50", "11:15", "11:25", "11:45", "11:55", "12:15", "12:25", "12:45", "12:55", "13:15", "13:25", "13:45", "13:55", "14:15", "14:25", "14:50", "15:30", "15:40", "16:00", "16:10", "16:45", "17:50", "18:25", "18:55", "19:40", "20:55", "22:05", "22:40", "23:40",
        // Tuesday
        "24:40",
    ]
    let toArriveBmc: [String] = [
        // Sunday
        "09:55", "10:55", "11:55", "12:55", "13:55", "14:55", "15:55", "17:25",
        "17:55", "18:25", "18:55", "19:25", "20:25", "21:25", "22:25", "23:25",
        // Monday
        "24:25", "07:50", "08:50", "09:00", "09:50", "10:00", "10:25", "10:35", "10:50", "11:00", "11:25", "11:35", "11:55", "12:05", "12:25", "12:35", "12:55", "13:05", "13:25", "13:35", "13:55", "14:05", "14:25", "14:35", "15:00", "15:40", "15:50", "16:10", "16:20", "16:55", "18:00", "18:35", "19:05", "19:50", "21:05", "22:15", "22:50", "23:50",
        // Tuesday
        "24:50",
    ]
    // Populate all NSDate arrays
    for time in toLeaveBmc {
        let dateInput: String = convertToToday + time
        if let newDate = dateFormatter.dateFromString(dateInput) {
            leaveBmc.append(newDate)
        }
    }
    for time in toArriveHc {
        let dateInput: String = convertToToday + time
        if let newDate = dateFormatter.dateFromString(dateInput) {
            arriveHc.append(newDate)
        }
    }
    for time in toLeaveHc {
        let dateInput: String = convertToToday + time
        if let newDate = dateFormatter.dateFromString(dateInput) {
            leaveHc.append(newDate)
        }
    }
    for time in toArriveBmc {
        let dateInput: String = convertToToday + time
        if let newDate = dateFormatter.dateFromString(dateInput) {
            arriveBmc.append(newDate)
        }
    }
}

func nextBus() {
    // Get current weekday
    let weekdayFormatter = NSDateFormatter()
    weekdayFormatter.dateFormat = "EEEE"
    let weekday = weekdayFormatter.stringFromDate(currentDate)
    var iterator: Int = 0
    let readableTimeFormatter = NSDateFormatter()
    readableTimeFormatter.dateFormat = "hh:mm"
    
    // Bryn Mawr to Haverford
    switch weekday {
        case "Sunday": iterator = 0
        case "Monday": iterator = 20
        case "Tuesday": iterator = 54
        case "Wednesday": iterator = 86
        case "Thursday": iterator = 123
        case "Friday": iterator = 156
        case "Saturday": iterator = 186
        default: iterator = 0
    }

    // While current date is later than date[iterator]
    while currentDate.compare(leaveBmc[iterator]) == NSComparisonResult.OrderedDescending {
        iterator++
    }
    // Print next n buses
    for var next = 0; next < 5; next++ {
        let nextBusTime: String = readableTimeFormatter.stringFromDate(leaveBmc[iterator % leaveBmc.count])
        let nextBusArrival: String = readableTimeFormatter.stringFromDate(arriveHc[iterator % arriveHc.count])
        print("\(next + 1) BMC to HC: \(nextBusTime) to \(nextBusArrival)")
        iterator++
    }
    
    // Haverford to Bryn Mawr
    switch weekday {
        case "Sunday": iterator = 0
        case "Monday": iterator = 20
        case "Tuesday": iterator = 54
        case "Wednesday": iterator = 86
        case "Thursday": iterator = 123
        case "Friday": iterator = 156
        case "Saturday": iterator = 186
        default: iterator = 0
    }

    // While current date is later than date[iterator]
    while currentDate.compare(leaveHc[iterator]) == NSComparisonResult.OrderedDescending {
        iterator++
    }
    // Print next n buses
    for var next = 0; next < 5; next++ {
        let nextBusTime: String = readableTimeFormatter.stringFromDate(leaveHc[iterator % leaveHc.count])
        let nextBusArrival: String = readableTimeFormatter.stringFromDate(arriveBmc[iterator % arriveBmc.count])
        print("\(next + 1) HC to BMC: \(nextBusTime) to \(nextBusArrival)")
        iterator++
    }

    
}
populateScheduleArrays()
nextBus()
