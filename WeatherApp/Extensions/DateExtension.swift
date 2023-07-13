//
//  DateExtension.swift
//  WeatherApp
//
//  Created by Metehan Karadeniz on 13.07.2023.
//

import Foundation

extension Date {
    
    func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d yyyy"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return nil
        }
    }

    func getCurrentHour() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let hour = calendar.component(.hour, from: now)
        return hour
    }

    
}
