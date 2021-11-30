//
//  Color.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 29/11/21.
//

import Foundation
import UIKit
import Charts


enum Color : String {
    case good
    case satisfactory
    case moderate
    case poor
    case verypoor
    case severe
    case unknown
    
    func getColor() -> UIColor {
        switch self {
        case .good:
           return NSUIColor(red: 67/255, green: 147/255, blue: 60/255, alpha: 1)
        case .satisfactory:
            return NSUIColor(red: 145/255, green: 190/255, blue: 65/255, alpha: 1)
        case .moderate:
            return NSUIColor.yellow
        case .poor:
            return NSUIColor.orange
        case .verypoor:
            return NSUIColor(red: 221/255, green: 39/255, blue: 38/255, alpha: 1)
        case .severe:
            return NSUIColor(red: 154/255, green: 27/255, blue: 27/255, alpha: 1)
        default:
            return NSUIColor(red: 154/255, green: 27/255, blue: 27/255, alpha: 1)
      }
    }
    
}

protocol AQIColorLevel {
    func setColor(aqiValue: Double) -> UIColor
}

extension AQIColorLevel where Self: UIViewController {
    
    func setColor(aqiValue: Double) -> UIColor {
        switch aqiValue {
        case 0..<51:
            return Color.good.getColor()
        case 51..<101:
            return Color.satisfactory.getColor()
        case 101..<201:
            return Color.moderate.getColor()
        case 201..<301:
            return Color.poor.getColor()
        case 301..<401:
            return Color.verypoor.getColor()
        case 401...501:
            return Color.severe.getColor()
        default:
            return Color.severe.getColor()
        }
    }
}
