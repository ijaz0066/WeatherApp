//
//  WeatherApiUrl.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import Foundation
//Api endpoints
enum EndPoint: String {
    case weather = "weather"
    case daily = "daily"
}

class WeatherApiUrl {
    static private let baseUrl = "http://api.openweathermap.org/data/2.5/"
}

extension WeatherApiUrl {
    
    //Functions to get api endpoints
    static func weather() -> URL {
        let url = URL(string: baseUrl + EndPoint.weather.rawValue)!
        return url
    }
}
