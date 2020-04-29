//
//  WeatherView.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Structure

/// Структура получаемых данных для отрисовки температуры
///
/// - cityName: Название города
/// - weatherDescription: Описание погоды
/// - temperature: Температура в цельсиях
struct WeatherData {
    var cityName: String?
    var weatherDescription: String?
    var temperature: Double?
}

@IBDesignable
class WeatherView: UIView {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet private weak var tempView: UIView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var loaderView: SpinnerView!
    
    var view: UIView!

    // MARK: - Closure
    
    private var retryLoadData: () -> () = { }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    // MARK: - Set data
    
    func setLoad() {
        loaderView.isHidden = false
        tempView.isHidden = true
        errorView.isHidden = true
    }
    
    func setError(buttonAction: @escaping () -> ()) {
        loaderView.isHidden = true
        tempView.isHidden = true
        errorView.isHidden = false
        self.retryLoadData = buttonAction
    }
    
    func setData(weather: WeatherData) {
        loaderView.isHidden = true
        tempView.isHidden = false
        errorView.isHidden = true
        cityName.text = weather.cityName
        weatherDescription.text = weather.weatherDescription
        temperature.text = "\(Int(weather.temperature ?? 0.0))°C"
    }
    
    // MARK: - UI Actions
    
    @IBAction func retryButton(_ sender: Any) {
        retryLoadData()
    }
    
    // MARK: - Set view

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WeatherView", bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        view?.prepareForInterfaceBuilder()
    }
}
