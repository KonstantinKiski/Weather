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

    //MARK: - Variables
    
    let apiKey = "57ef83936d3ef84b5120b1cde54f48f3"
    let lang = "ru"
    
    //MARK: - Init

    init() {}

    //MARK: - Functions
    
    /// Получаем детальное описание поготы на текущее время
    /// - Parameter cityId: id города
    /// - Parameter completion: замыкание, выполняемое при получении данных
    /// - Returns: (DetailWeather, NetworkManagerError), где DetailWeather - модель с погодой, а NetworkManagerError - ошибка, если она есть
    func getDetailWeather(cityId: Int, completion: @escaping (DetailWeather?, NetworkManagerError?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&lang=\(lang)&appid=\(apiKey)"
        AF.request(urlString).response { response in
            
            guard let data = response.data else {
                completion(nil, NetworkManagerError(kind: .serverIsDown))
                return
            }
            do {
                let decoder = JSONDecoder()
                let fullWeather = try decoder.decode(DetailWeather.self, from: data)
  
                guard fullWeather.cod == 200 else {
                    completion(nil, NetworkManagerError(kind: .serverIsDown))
                    return
                }
                completion(fullWeather, nil)
            } catch let error {
                completion(nil, error as? NetworkManagerError)
            }
        }
    }
    
    /// Получаем прогноз погоды на 3-е суток с промежутков в 3 часа
    /// - Parameter cityId: id города
    /// - Parameter completion: замыкание, выполняемое при получении данных
    /// - Returns: (Forecast, NetworkManagerError), где Forecast - модель прогноза погоды в котором содержится массив DetailWeather, а NetworkManagerError - ошибка, если она есть
    func getForecastWeather(cityId: Int, completion: @escaping (Forecast?, NetworkManagerError?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&lang=\(lang)&appid=\(apiKey)"
        AF.request(urlString).response { response in
            
            guard let data = response.data else {
                completion(nil, NetworkManagerError(kind: .serverIsDown))
                return
            }
            do {
                let decoder = JSONDecoder()
                let forecast = try decoder.decode(Forecast.self, from: data)
                
                completion(forecast, nil)
            } catch let error {
                completion(nil, error as? NetworkManagerError)
            }
        }
    }
}
