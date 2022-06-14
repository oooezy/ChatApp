//
//  Date + Helpers.swift
//  ChatApp
//
//  Created by 이은지 on 2022/06/13.
//

import Foundation

extension Date {
    func descriptiveString(dateStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.locale = Locale(identifier: "ko")

        let daysBetween = self.daysBetween(date: Date())
        
        if daysBetween == 0 {
            return "오늘"
        } else if daysBetween == 1 {
            return "어제"
        } else if daysBetween < 3 {
            let weekdayIndex = Calendar.current.component(.weekday, from: self) - 1
            return formatter.weekdaySymbols[weekdayIndex]
        } else {
            formatter.dateFormat = "yyyy년 MM월 dd일"
            formatter.locale = Locale(identifier: "ko")
            let date = formatter.string(from: self)
            return date
        }
    }
    
    func daysBetween(date: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        if let daysBetween = calendar.dateComponents([.day], from: date1, to: date2).day {
            return daysBetween
        }
        return 0
    }
}
