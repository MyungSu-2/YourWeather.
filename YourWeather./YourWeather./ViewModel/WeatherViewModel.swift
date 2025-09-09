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
    
    init(cityName: String = "Seoul") {
        fetchWeatherData(for: cityName)
    }
    
    init() {
        
    }
    
    func fetchWeatherData(for cityName: String) {
        Task {
            self.weatherData = await WeatherManager.shared.fetchOWM(city: cityName, apiKey: SecretManager.shared.openWeatherAPIKey)
        }
    }
    
    func saveWeatherToSharedDefaults(to destination: Bool) {
        let sharedDefaults = UserDefaults(suiteName: "group.com.YourWeather_")
        switch destination {
        case false:
            if let encoded = try? JSONEncoder().encode(weatherData) {
                sharedDefaults?.set(encoded, forKey: "myWeatherData")
            }
        case true:
            if let encoded = try? JSONEncoder().encode(weatherData) {
                sharedDefaults?.set(encoded, forKey: "selectedWeatherData")
            }
        }
    }
    
    
}
