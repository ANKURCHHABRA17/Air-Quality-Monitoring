//
//  AQICustomTableViewCell.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 28/11/21.
//

import UIKit

class AQICustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var aqiValue: UILabel!
    @IBOutlet weak var timeElapsed: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func setData(name: String , aqi: Double, time: Date) {
        cityName.text = name
        aqiValue.text = String(format: "%.2f", aqi)
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        let relativeDate = formatter.localizedString(for: time, relativeTo: Date())

        if relativeDate.contains("in 0 seconds") {
            timeElapsed.text = " updated just now"
        } else {
            timeElapsed.text = " updated " + relativeDate
        }
        
    }
}
