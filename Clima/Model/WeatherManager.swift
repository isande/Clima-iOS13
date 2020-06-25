//
//  WeatherManager.swift
//  Clima
//
//  Created by Peggy Wollenhaupt on 6/25/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL="http://api.openweathermap.org/data/2.5/weather?appid=83044575fadc6388ea92c4b2254b0cae&units=imperial"
    
    func fetchWeather(cityName: String) {
        if let zip = Int(cityName) {
            let urlString = "\(weatherURL)&zip=\(zip)"
            print(urlString)
        } else {
            let urlString = "\(weatherURL)&q=\(cityName)"
            print(urlString)
        }
    }
}
