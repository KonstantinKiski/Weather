//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Константин Киски on 29.04.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

import Foundation
import UIKit

/// Структура получаемых данных для отрисовки погоды в определенный час
///
/// - info: описание погоды
/// - date: Дата для которой прогназриуема температура
/// - temperature: Температура в цельсиях
struct WeatherForecastData {
    var temperature: Double?
    var date: Date?
    var info: String?
}

class WeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet private weak var forecastCellView: ForecastCellView!
    
    // MARK: - Set data
    
    func setData(data: WeatherForecastData) {
        forecastCellView.setData(data: data)
    }
}
