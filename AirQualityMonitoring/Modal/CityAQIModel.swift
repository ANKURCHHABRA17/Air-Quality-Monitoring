//
//  CityAQI.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 28/11/21.
//

import Foundation

struct CityAQI: Decodable {
    var city: String
    var aqi: Double
    let time: Date? = Date()
}

extension CityAQI: Equatable {
    // Customize Equitable Protociol
    static func ==(lhs: CityAQI, rhs: CityAQI) -> Bool {
        return lhs.city == rhs.city
    }
}
