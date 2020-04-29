//
//  NetworkingManager.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//
import Foundation

class NetworkManager: NSObject {
    
    static var Weather: WeatherNetworking {
        return WeatherNetworking()
    }
}
