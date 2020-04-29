//
//  Forecast.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation

struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Coordinations?
    var country: String?
}

class Forecast: Codable {
    
    var cod: Int!
    var message: String?
    var cnt: Int?
    var city: City?
    var hoursList: [DetailWeather]?
    
    private enum CodingKeys: String, CodingKey {
        case cod, message, cnt, city, hoursList = "list"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cnt = try? container.decode(Int.self, forKey: .cnt)
        self.cod = try? container.decode(Int.self, forKey: .cod)
        self.message = try? container.decode(String.self, forKey: .message)
        self.city = try? container.decode(City.self, forKey: .city)
        self.hoursList = try? container.decode([DetailWeather].self, forKey: .hoursList)
    }
}
