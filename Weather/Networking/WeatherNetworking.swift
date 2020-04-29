//
//  WeatherNetworking.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import Alamofire

class WeatherNetworking {

    init() {}
    
    func getDetailWeather(cityId: Int, completion: @escaping (DetailWeather?, NetworkManagerError?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=appid"
        
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let fullWeather = try decoder.decode(DetailWeather.self, from: data)
                
                if fullWeather.cod == 200 {
                    completion(fullWeather, nil)
                }
                completion(nil, NetworkManagerError(kind: .serverIsDown))
            } catch let error {
                print(error)
                completion(nil, error as? NetworkManagerError)
            }
        }
    }
    
    
    func getForecastWeather(cityId: Int, completion: @escaping (Forecast?, NetworkManagerError?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=appid"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let forecast = try decoder.decode(Forecast.self, from: data)
                
                if forecast.cod == 200 {
                    completion(forecast, nil)
                }
                completion(nil, NetworkManagerError(kind: .serverIsDown))
            } catch let error {
                print(error)
                completion(nil, error as? NetworkManagerError)
            }
        }
    }

}
