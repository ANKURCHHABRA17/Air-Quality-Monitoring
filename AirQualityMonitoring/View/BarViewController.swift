//
//  BarViewController.swift
//  BarChartDemo
//
//  Copied from danielgindi/Charts ( Customize as per need)
//


import UIKit
import Charts

class BarViewController: UIViewController, ChartViewDelegate,AQIColorLevel {

    @IBOutlet weak var barChartView: BarChartView!
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    var cityName: String!
    var displayDataAqi: [Double] = []
    var displayDatetime: [Date] = []
    var displayxAxis: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cityName + " Chart"
        barChartView.delegate = self
        axisFormatDelegate = self
        
        for (_, val) in displayDatetime.enumerated() {
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "mm:ss a"
            let dateTime: String = formatter.string(from: val)
            
            displayxAxis.append(String(dateTime))
        }
        
        setChart(dataPoints: displayxAxis, values: displayDataAqi)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        // Prevent from setting an empty data set to the chart (crashes)
        guard dataPoints.count > 0 else { return }
        
        var dataEntries = [BarChartDataEntry]()
        
        for i in 0..<values.count {
            let entry = BarChartDataEntry(x: Double(i), y: values[i], data: displayxAxis as AnyObject?)
            dataEntries.append(entry)
            
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.drawValuesEnabled = false
        chartDataSet.colors = [UIColor.red]
       // chartDataSet.colors = [UIColor.lightGray]
        chartDataSet.highlightColor = UIColor.orange.withAlphaComponent(0.3)
        chartDataSet.highlightAlpha = 1
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        let xAxisValue = barChartView.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        
        var colorData :[UIColor] = []
        for (_,val)in values.enumerated() {
            colorData.append(setColor(aqiValue: val))
        }
        
        chartDataSet.colors = colorData    //multiple colors
        
        //Animation bars
        barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0, easingOption: .easeInCubic)
        
        // X axis configurations
        barChartView.xAxis.granularityEnabled = true
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.drawAxisLineEnabled = true
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 15.0)
        barChartView.xAxis.labelTextColor = UIColor.black
        barChartView.xAxis.labelPosition = .bottom
        
        barChartView.leftAxis.axisMinimum = 0
        barChartView.leftAxis.axisMaximum = 500
        
        // Right axis configurations
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        
        // Other configurations
        barChartView.highlightPerDragEnabled = false
        barChartView.chartDescription?.text = ""
        barChartView.legend.enabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.scaleYEnabled = true
        
        barChartView.drawMarkers = true
        
        let l = barChartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        
        // On tapped bar marker  before add BalloonMarker.swift
        
        let marker =  BalloonMarker(color: UIColor.white, font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.black, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 15.0, right: 7.0))
        marker.chartView = barChartView
        barChartView.marker = marker
        
    }
    
}
extension BarViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return displayxAxis[Int(value)]//months[Int(value)]
    }
}




