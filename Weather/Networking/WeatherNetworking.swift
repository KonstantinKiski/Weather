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
        let urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=439d4b804bc8187953eb36d2a8c26a02"
        
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
}
