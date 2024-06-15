//
//  DateUtils.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 15.06.2024.
//

import Foundation

struct DateUtils {
    static func formattedDate(from isoDateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = inputFormatter.date(from: isoDateString) else {
            return isoDateString
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        
        let formattedDate = outputFormatter.string(from: date)
        
        return formattedDate
    }
}
