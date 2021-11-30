//
//  ViewController.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 28/11/21.
//

import UIKit

protocol UpdateAQITableViewProtocol: class {
    func reloadTableView()
}

class ViewController: UIViewController,URLSessionWebSocketDelegate, AQIColorLevel {
    
    @IBOutlet weak var tableView: UITableView!
    private var aqiViewModel : AQIViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setTheNavigationBar()
        self.aqiViewModel = AQIViewModel()
        self.aqiViewModel.aqitableViewProtocol = self
    }
    
    func setTheNavigationBar() {
        self.title = "AQI Data"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate ,UpdateAQITableViewProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aqiViewModel.aqiData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AQICustomCell", for: indexPath) as? AQICustomTableViewCell else { return UITableViewCell()}
        
        cell.backgroundColor = setColor(aqiValue: aqiViewModel.aqiData[indexPath.row].aqi)
        
        cell.setData(name: aqiViewModel.aqiData[indexPath.row].city, aqi: aqiViewModel.aqiData[indexPath.row].aqi, time: aqiViewModel.aqiData[indexPath.row].time ?? Date())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName = aqiViewModel.aqiData[indexPath.row].city
        
        var filterData : [CityAQI] = []
        for data in aqiViewModel.oldAqiData {
            let data = data.filter({$0.city == cityName})
            filterData.append(contentsOf: data)
        }
        
        let data =  filterData.sorted(by: { $0.time ?? Date() < $1.time ?? Date() })
        let aqiData = data.map({ $0.aqi })
        let timeData = data.map({$0.time ?? Date()})
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let stackBarViewController = storyBoard.instantiateViewController(withIdentifier: "StackedBarChart") as! BarViewController
               stackBarViewController.cityName = cityName
              stackBarViewController.displayDataAqi = aqiData
              stackBarViewController.displayDatetime = timeData
        self.navigationController?.pushViewController(stackBarViewController, animated: true)
       
    }
}

