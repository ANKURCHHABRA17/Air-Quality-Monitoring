//
//  AQIViewModel.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 28/11/21.
//

import UIKit

class AQIViewModel: NSObject {
    
   private var webSocketDelegate: WebSocket!
    
    weak var aqitableViewProtocol: UpdateAQITableViewProtocol?
    var aqiData : [CityAQI] = []
    var oldAqiData: [[CityAQI]] = [[]]
    
    override init() {
        super.init()
        self.webSocketDelegate = WebSocket()
        let session = URLSession(configuration: .default, delegate: webSocketDelegate, delegateQueue: OperationQueue())
        webSocketDelegate.startWebSocketInteraction(session: session)
        
        self.webSocketDelegate.bindAqiDataToViewModel = { [weak self] in
           // self?.aqiData = self?.webSocketDelegate.aqiData ?? []
           // self?.aqiData.append(contentsOf: self?.webSocketDelegate.aqiData ?? [])
           
            
             var updatedAQIData = self?.webSocketDelegate.aqiData ?? []
            updatedAQIData.mergeElements(newElements:self?.aqiData ?? [])
            self?.aqiData =  updatedAQIData.sorted(by: { $0.city < $1.city })
            
            if let data = self?.aqiData {
                
                if self?.oldAqiData.count ?? 0 >= 5 {
                    self?.oldAqiData.remove(at: 0)
                }
                
                self?.oldAqiData.append(data)
            }
            
            self?.aqitableViewProtocol?.reloadTableView()
        }
    }
}
