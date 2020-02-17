//
//  RestApiService.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

struct RestApiConfiguration {
    var baseUrl: URL
    var timeout: Double = 10
    
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
}

class RestApiService {
    var configuration: RestApiConfiguration
    var appId: String = "b973995c78707428615897ec08ea7dfb"
    
    init(_ configuration: RestApiConfiguration) {
        self.configuration = configuration
    }
    
    convenience init(baseUrl: URL) {
        let configuration = RestApiConfiguration.init(baseUrl: baseUrl)
        self.init(configuration)
    }
    
    func makeRequst(coordinate: CLLocationCoordinate2D, method: String, data: Data? = nil) -> URLRequest {
        // lat=-16.92&lon=145.77&cnt=7 "%@?lat=%f&lon=%f&cnt=7"
        let urlString = String.init(format: "%@?lat=%@&lon=%@&cnt=1&units=metric&APPID=%@", self.configuration.baseUrl.absoluteString, String(coordinate.latitude), String(coordinate.longitude), appId)
        let requestUrl = URL(string: urlString)
        var request = URLRequest(url: requestUrl!)
        request.httpMethod = method
        request.timeoutInterval = self.configuration.timeout
        
        if data != nil {
            request.httpBody = data
        }
        
        return request
    }
    
    func parseResponseResults(response: DataResponse<Any>, onSuccess: @escaping (_ response: DataResponse<Any>, _ data: NSDictionary) -> Void, onError: ((_ response: DataResponse<Any>, _ error: Error) -> Void )? = nil) {
        switch response.result {
        case .success:
            guard let data = response.result.value as? NSDictionary else { return }
            onSuccess(response, data)
        case .failure(let error):
            if onError != nil {
                onError!(response, error)
            }
        }
    }
    func getRequest(coordinate: CLLocationCoordinate2D, onSuccess: @escaping (_ response: DataResponse<Any>, _ data: NSDictionary) -> Void, onError: ((_ response: DataResponse<Any>, _ error: Error) -> Void)? = nil ) {
        let request = self.makeRequst(coordinate: coordinate, method: HTTPMethod.get.rawValue)
        Alamofire.request(request as URLRequestConvertible).responseJSON { response in
            self.parseResponseResults(response: response, onSuccess: onSuccess, onError: onError)
        }
    }
}
