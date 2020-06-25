//
//  WeatherManager.swift
//  Clima
//
//  Created by Peggy Wollenhaupt on 6/25/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid=83044575fadc6388ea92c4b2254b0cae&units=imperial"
    
    func fetchWeather(cityName: String) {
        if let zip = Int(cityName) {
            let urlString = "\(weatherURL)&zip=\(zip)"
            performRequest(urlString: urlString)
        } else {
            let urlString = "\(weatherURL)&q=\(cityName)"
            performRequest(urlString: urlString)
        }
    }
    
    func performRequest(urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            // 3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            // 4. Start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString ?? "Error")
        }
    }
}
