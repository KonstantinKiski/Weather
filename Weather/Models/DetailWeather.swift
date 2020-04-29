//
//  DetailWeather.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation

struct Coordinations: Codable {
    var lon: Double?
    var lat: Double?
}

struct ShortWeather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct MainWeather: Codable {
    var temp: Double?
    var feelsLike: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Double?
    var humidity: Double?
    var seaLevel: Double?
    var grndLevel: Double?
    var tempCelsius: Double {
        if let fahrenheit = temp {
            return (fahrenheit-32.0)/1.8
        }
        return temp ?? 0.0
    }
}

struct Wind: Codable {
    var speed: Double?
    var deg: Double?
}

struct Clouds: Codable {
    var all: Double?
}

struct SystemMessage: Codable {
    var message: Double?
    var country: String?
    var sunrise: Double?
    var sunset: Double?
    var sunsetDate: Date {
        if let dateInterval = sunset {
            return Date(timeIntervalSince1970: dateInterval)
        }
        return Date()
    }
    var sunriseDate: Date {
        if let dateInterval = sunrise {
            return Date(timeIntervalSince1970: dateInterval)
        }
        return Date()
    }
}

class DetailWeather: Codable {
    
    var id: Int!
    var cityName: String?
    var unixDate: Double?
    var base: String?
    var wind: Wind?
    var clouds: Clouds?
    var systemMessage: SystemMessage?
    var mainWeather: MainWeather?
    var shortWeather: ShortWeather?
    var coordinations: Coordinations?
    var cod: Int?
    var date: Date {
        if let dateInterval = unixDate {
            return Date(timeIntervalSince1970: dateInterval)
        }
        return Date()
    }

    private enum CodingKeys: String, CodingKey {
        case id, cityName  = "name", unixDate = "dt", base, wind, clouds, systemMessage = "sys"
        case mainWeather = "main", shortWeather = "weather", coordinations = "coord", cod
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.cityName = try? container.decode(String.self, forKey: .cityName)
        self.unixDate = try? container.decode(Double.self, forKey: .unixDate)
        self.base = try? container.decode(String.self, forKey: .base)
        self.wind = try? container.decode(Wind.self, forKey: .wind)
        self.clouds = try? container.decode(Clouds.self, forKey: .clouds)
        self.cod = try? container.decode(Int.self, forKey: .cod)
        self.systemMessage = try? container.decode(SystemMessage.self, forKey: .systemMessage)
        self.mainWeather = try? container.decode(MainWeather.self, forKey: .mainWeather)
        self.shortWeather = try? container.decode(ShortWeather.self, forKey: .shortWeather)
        self.coordinations = try? container.decode(Coordinations.self, forKey: .coordinations)
    }
}
