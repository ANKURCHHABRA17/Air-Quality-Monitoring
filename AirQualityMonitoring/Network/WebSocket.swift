//
//  NetworkLayer.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 28/11/21.
//

import Foundation

internal var timeToRefresh = 10

class WebSocket: NSObject, URLSessionWebSocketDelegate {
    
    let url = URL(string: "ws://city-ws.herokuapp.com")!
    var webSocketTask: URLSessionWebSocketTask!
    var aqiData : [CityAQI] = [] {
        didSet {
            self.bindAqiDataToViewModel()
        }
    }
    
    var bindAqiDataToViewModel : (() -> ()) = {}
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Web Socket did connects")
         ping()
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web Socket did disconnect")
    }
    
    func close() {
      let reason = "Closing connection".data(using: .utf8)
      webSocketTask.cancel(with: .goingAway, reason: reason)
    }
    
    func startWebSocketInteraction(session: URLSession ){
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask.resume()
    }
    
    func ping() {
      webSocketTask.sendPing { error in
        if let error = error {
          print("Error when sending PING \(error)")
        } else {
            print("Web Socket connection is alive")
            DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [self] in
                ping()
            }
        }
      }
    }
    
    func receive() {
        webSocketTask.receive { [self] result in
        switch result {
        case .success(let message):
          switch message {
          case .data(let data):
            print("Data received \(data)")
          case .string(let text):
            print("Text received \(text)")
              do {
                  let jsonData = try JSONSerialization.data(withJSONObject:  text.toJSON(), options: [])
                  aqiData = try JSONDecoder().decode([CityAQI].self, from: jsonData)
              } catch {
                  print("Error in json parsing")
              }
          @unknown default:
              print("unknown value")
          }
        case .failure(let error):
          print("Error when receiving \(error)")
        }
            DispatchQueue.global().asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(timeToRefresh)) { [self] in
                receive()
            }
       
      }
    }
}
