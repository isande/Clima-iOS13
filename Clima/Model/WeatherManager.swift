//
//  WeatherManager.swift
//  Clima
//
//  Created by Peggy Wollenhaupt on 6/25/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid=83044575fadc6388ea92c4b2254b0cae&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        if let zip = Int(cityName) {
            let urlString = "\(weatherURL)&zip=\(zip)"
            performRequest(with: urlString)
        } else {
            if let safeString = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let urlString = "\(weatherURL)&q=\(safeString),us"
                performRequest(with: urlString)
            }
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }

            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let desc = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp, description: desc)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
