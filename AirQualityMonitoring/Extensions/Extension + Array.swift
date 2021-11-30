//
//  Extension + Array.swift
//  AirQualityMonitoring
//
//  Created by Ankur Chhabra on 29/11/21.
//

import Foundation

extension Array where Element : Equatable {

  public mutating func mergeElements<C : Collection>(newElements: C) where C.Iterator.Element == Element{
    let filteredList = newElements.filter({!self.contains($0)})
    self.append(contentsOf: filteredList)
  }

}
