//
//  WeatherViewController.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - UI Elements

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var topView: WeatherView!
    @IBOutlet private weak var placeholderBottom: PlaceholderView!
    @IBOutlet private weak var sunsetView: SunView!
    @IBOutlet private weak var sunriseView: SunView!
    
    // MARK: - Variables
    
    private var forecastList: Forecast?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoadData()
    }

    // MARK: - Private helper functions
    
    private func startLoadData() {
        getWeather()
        getForecastList()
    }
    
    // MARK: - Get data functions
    
    private func getWeather() {
        topView.setLoad()
        NetworkManager.Weather.getDetailWeather(cityId: 479123)  { weather, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    let retryLoadData = {
                        self.getWeather()
                    }
                    self.topView.setError(buttonAction: retryLoadData)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.sunsetView.isHidden = false
                self.sunriseView.isHidden = false
                self.sunriseView.setSun(date: weather?.systemMessage?.sunriseDate ?? Date(), image: UIImage(systemName: "sunrise")!)
                self.sunsetView.setSun(date: weather?.systemMessage?.sunsetDate ?? Date(), image: UIImage(systemName: "sunset")!)
                self.topView.setData(weather: WeatherData(cityName: weather?.cityName ?? "", weatherDescription: weather?.shortWeather?.first?.description, temperature: weather?.mainWeather?.tempCelsius))
            }
        }
    }
    
    private func getForecastList() {
        placeholderBottom.isHidden = false
        collectionView.isHidden = true
        placeholderBottom.setLoad()
        NetworkManager.Weather.getForecastWeather(cityId: 479123)  { forecast, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    let retryLoadData = {
                        self.getForecastList()
                    }
                    self.placeholderBottom.setError(buttonAction: retryLoadData)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.placeholderBottom.isHidden = true
                self.collectionView.isHidden = false
                self.forecastList = forecast
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastList?.cnt ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WeatherCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "wheatherCell", for: indexPath) as! WeatherCollectionViewCell
        let forecast = forecastList?.hoursList?[indexPath.row]
        cell.setData(data: WeatherForecastData(temperature: forecast?.mainWeather?.tempCelsius, date: forecast?.date, info: forecast?.shortWeather?.first?.description?.lowercased()))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = CGFloat(140.0)
        let itemHeight = CGFloat(140.0)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
