//
//  ViewController.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeather()
    }


    func getWeather() {
        NetworkManager.Weather.getDetailWeather(cityId: 479123)  { weather, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            print(weather?.cityName ??  "")
        }
    }
}

