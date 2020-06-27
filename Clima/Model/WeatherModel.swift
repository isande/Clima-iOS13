//
//  WeatherModel.swift
//  Clima
//
//  Created by Peggy Wollenhaupt on 6/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    var temperatureString: String {
        String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...299:
            return "cloud.bolt.rain"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 700...762:
            return "sun.haze"
        case 771:
            return "wind"
        case 781:
            return "tornado"
        case 800...801:
            return "sun.max"
        case 802...803:
            return "cloud.sun"
        case 804:
            return "cloud"
        default:
            return "questionmark.circle"
        }
    }
}
