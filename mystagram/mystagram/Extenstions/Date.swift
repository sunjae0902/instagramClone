//
//  Date.swift
//  mystagram
//
//  Created by sunjae on 11/8/24.
//

import Foundation

extension Date {
    func relativeTimeString() -> String {
        let now = Date()
        let currentYear = Calendar.current.component(.year, from: now)
        guard let thisYearFirstDay = Calendar.current.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else { return "" }
        
        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .weekOfMonth, .month], from: self, to: now)
        // 시간 텀을 각각 계산해서 반환해줌
        
        if let month = components.month, month >= 1 {
            let dateFormatter = DateFormatter()
            
            if self < thisYearFirstDay { // 작년 이전
                dateFormatter.dateFormat = "yyyy년 M월 d일"
            } else { // 올해
                dateFormatter.dateFormat = "M월 d일"
            }
            return dateFormatter.string(from: self)
        } else if let week = components.weekOfMonth, week >= 1 {
            return "\(week)주 전"
        } else if let day = components.day, day >= 1 {
            return "\(day)일 전"
        } else if let hour = components.hour, hour >= 1 {
            return "\(hour)시간 전"
        } else if let minute = components.minute, minute >= 1 {
            return "\(minute)분 전"
        } else if let second = components.second, second >= 1 {
            return "\(second)초 전"
        } else {
            return "방금"
        }
    }
}
