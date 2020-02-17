//
//  WeatherViewController.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    @IBOutlet weak var skyCondition: UILabel!
    var weather: Weather?
    var city: String?
    var temprature: Temprature?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityName.text = city
        temp.text = String(temprature?.temp ?? 0)
        minTemp.text = String(temprature?.minimumTemp ?? 0)
        maxTemp.text = String(temprature?.maximumTemp ?? 0)
        feelsLike.text = String(temprature?.feelsLike ?? 0)
        humidity.text = String(temprature?.humidity ?? 0)
        pressure.text = String(temprature?.pressure ?? 0)
        skyCondition.text = weather?.description
        
    }
}
