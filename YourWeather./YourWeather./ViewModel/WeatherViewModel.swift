//
//  viewModel.swift
//  YourWeather.
//
//  Created by 박선린 on 9/9/25.
//
import SwiftUI
import WeatherKit
import CoreLocation

@Observable
class WeatherViewModel {
    
    var weatherData: OWMWeather?
    var cityName: String = "" {
        didSet {
            fetchWeatherData(for: cityName)
        }
    }
    
    init(cityName: String) {
        fetchWeatherData(for: cityName)
    }
    
    func fetchWeatherData(for cityName: String) {
        Task {
            self.weatherData = await WeatherManager.shared.fetchOWM(city: cityName, apiKey: SecretManager.shared.openWeatherAPIKey)
        }
    }
    
    
}
