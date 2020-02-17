//
//  WeatherViewModel.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import Foundation
import MapKit

protocol WeatherViewModelDelegate: class {
  func onFetchCompleted()
  func onFetchFailed(with reason: String)
}

class WeatherViewModel {
    private weak var delegate: WeatherViewModelDelegate?
    
    var weather: Weather!
    var temprature: Temprature!
    var city: String!
    
    let restApiClient: RestApiService!
    
    init(restApiClient: RestApiService, delegate: WeatherViewModelDelegate) {
        self.restApiClient = restApiClient
        self.delegate = delegate
    }
    
    func fetchWeatherData(coordinate: CLLocationCoordinate2D) {
        restApiClient.getRequest(coordinate: coordinate, onSuccess: { (response, dict) in
            print("")
            let decodedResponse = try! JSONDecoder().decode(WeatherResponse.self, from: response.data!)
            self.weather = decodedResponse.weather.first
            self.temprature = decodedResponse.temp
            self.city = decodedResponse.cityName
            self.delegate?.onFetchCompleted()
            
        }) { (response, error) in
            self.delegate?.onFetchFailed(with: error.localizedDescription)
        }

    }
    
    
}
