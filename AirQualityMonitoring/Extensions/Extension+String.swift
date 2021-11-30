//
//  Extension+String.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 29/11/21.
//

import Foundation

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
