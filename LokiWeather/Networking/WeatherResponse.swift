//
//  WeatherResponse.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let temp: Temprature
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case  temp = "main"
        case cityName = "name"
    }
}
