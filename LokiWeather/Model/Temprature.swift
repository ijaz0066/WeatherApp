//
//  Temprature.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import Foundation

struct Temprature: Decodable {
    let temp: Double
    let feelsLike: Double
    let minimumTemp: Double
    let maximumTemp: Double
    let pressure: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minimumTemp = "temp_min"
        case maximumTemp = "temp_max"
        case pressure
        case humidity
        
    }
    
    init(temp: Double, feelsLike: Double, minimumTemp: Double, maximumTemp: Double, pressure: Double, humidity: Double) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.minimumTemp = minimumTemp
        self.maximumTemp = maximumTemp
        self.pressure = pressure
        self.humidity = humidity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let temp = try container.decode(Double.self, forKey: .temp)
        let feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        let minimumTemp = try container.decode(Double.self, forKey: .minimumTemp)
        let maximumTemp = try container.decode(Double.self, forKey: .maximumTemp)
        let pressure = try container.decode(Double.self, forKey: .pressure)
        let humidity = try container.decode(Double.self, forKey: .humidity)
        self.init(temp: temp, feelsLike: feelsLike, minimumTemp: minimumTemp, maximumTemp: maximumTemp, pressure: pressure, humidity: humidity)
    }
}

